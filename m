Return-Path: <SRS0=xbEg=53=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 202B7C2BB85
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Apr 2020 07:37:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE50120857
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Apr 2020 07:37:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726010AbgDKHhD convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Apr 2020 03:37:03 -0400
Received: from poy.remlab.net ([94.23.215.26]:53062 "EHLO
        ns207790.ip-94-23-215.eu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725869AbgDKHhD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Apr 2020 03:37:03 -0400
Received: from basile.remlab.net (87-92-31-51.bb.dnainternet.fi [87.92.31.51])
        (Authenticated sender: remi)
        by ns207790.ip-94-23-215.eu (Postfix) with ESMTPSA id 8CC435FD38;
        Sat, 11 Apr 2020 09:37:00 +0200 (CEST)
From:   =?ISO-8859-1?Q?R=E9mi?= Denis-Courmont <remi@remlab.net>
To:     Vito Caputo <vcaputo@pengaru.com>
Cc:     netdev@vger.kernel.org, courmisch@gmail.com, davem@davemloft.net,
        kuba@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: kernel BUG at net/phonet/socket.c:LINE!
Date:   Sat, 11 Apr 2020 10:36:59 +0300
Message-ID: <1806223.auBmcZeozp@basile.remlab.net>
Organization: Remlab
In-Reply-To: <20200411004320.py2cashe4edsjdzp@shells.gnugeneration.com>
References: <00000000000062b41d05a2ea82b0@google.com> <20200411004320.py2cashe4edsjdzp@shells.gnugeneration.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

	Hi,

Le lauantaina 11. huhtikuuta 2020, 3.43.20 EEST Vito Caputo a écrit :
> I stared a bit at the code surrounding this report, and maybe someone more
> familiar with the network stack can clear something up for me real quick:
> > RIP: 0010:pn_socket_autobind net/phonet/socket.c:213 [inline]
> 
> net/phonet/socket.c:
> 202 static int pn_socket_autobind(struct socket *sock)
> 203 {
> 204         struct sockaddr_pn sa;
> 205         int err;
> 206
> 207         memset(&sa, 0, sizeof(sa));
> 208         sa.spn_family = AF_PHONET;
> 209         err = pn_socket_bind(sock, (struct sockaddr *)&sa,
> 210                                 sizeof(struct sockaddr_pn));
> 211         if (err != -EINVAL)
> 212                 return err;
> 213         BUG_ON(!pn_port(pn_sk(sock->sk)->sobject));
> 214         return 0; /* socket was already bound */
> 215 }
> 
> line 213 is the BUG_ON for !sock->sk->sobject, a phonet-specific member:
> 
> include/net/phonet/phonet.h:
>  23 struct pn_sock {
>  24         struct sock     sk;
>  25         u16             sobject;
>  26         u16             dobject;
>  27         u8              resource;
>  28 };
> 
> pn_socket_autobind() expects that to be non-null whenever pn_socket_bind()
> returns -EINVAL, which seems odd, but the comment claims it's already bound,
> let's look at pn_socket_bind():
> 
> net/phonet/socket.c:
> 156 static int pn_socket_bind(struct socket *sock, struct sockaddr *addr,
> int len) 157 {
> 158         struct sock *sk = sock->sk;
> 159         struct pn_sock *pn = pn_sk(sk);
> 160         struct sockaddr_pn *spn = (struct sockaddr_pn *)addr;
> 161         int err;
> 162         u16 handle;
> 163         u8 saddr;
> 164
> 165         if (sk->sk_prot->bind)
> 166                 return sk->sk_prot->bind(sk, addr, len);
> 167
> 168         if (len < sizeof(struct sockaddr_pn))
> 169                 return -EINVAL;
> 170         if (spn->spn_family != AF_PHONET)
> 171                 return -EAFNOSUPPORT;
> 172
> 173         handle = pn_sockaddr_get_object((struct sockaddr_pn *)addr);
> 174         saddr = pn_addr(handle);
> 175         if (saddr && phonet_address_lookup(sock_net(sk), saddr))
> 176                 return -EADDRNOTAVAIL;
> 177
> 178         lock_sock(sk);
> 179         if (sk->sk_state != TCP_CLOSE || pn_port(pn->sobject)) {
> 180                 err = -EINVAL; /* attempt to rebind */
> 181                 goto out;
> 182         }
> 183         WARN_ON(sk_hashed(sk));
> 184         mutex_lock(&port_mutex);
> 185         err = sk->sk_prot->get_port(sk, pn_port(handle));
> 186         if (err)
> 187                 goto out_port;
> 188
> 189         /* get_port() sets the port, bind() sets the address if
> applicable */ 190         pn->sobject = pn_object(saddr,
> pn_port(pn->sobject));
> 191         pn->resource = spn->spn_resource;
> 192
> 193         /* Enable RX on the socket */
> 194         err = sk->sk_prot->hash(sk);
> 195 out_port:
> 196         mutex_unlock(&port_mutex);
> 197 out:
> 198         release_sock(sk);
> 199         return err;
> 200 }
> 
> 
> The first return branch in there simply hands off the bind to and
> indirection sk->sk_prot->bind() if present.  This smells ripe for breaking
> the assumptions of that BUG_ON().

I believe that this is in line with the design of the socket stack within the 
Linux kernel. 'struct proto_ops' carries the protocol family operations, then 
'struct proto' carries the protocol operations.

Admittedly, Phonet only had one datagram and one stream protocol ever written, 
as the hardware development ceased. So in practice, there is a 1:1 mapping 
between the two, and sk_prot.bind is always NULL.

> I'm assuming there's no point for such an indirection if not to enable a
> potentially non-phonet-ops hook, otherwise we'd just be do the bind.

In my understanding, that's *not* what sk_prot is for, no. It's rather meant 
to specialize the socket calls on a per-protocol basis.

For instance, UDP and UDP-Lite share their address family 'struct proto_ops' 
(either inet_dgram_ops or inet6_dgram_ops) but they have different 
'struct proto'.

> If not, isn't this plain recursive?  Color me confused.  Will other bind()
> implementations return -EINVAL when already bound with sobject set? no.

As far as I can find, there are no cases where the bind pointer would not be 
NULL in upstream kernel. This can only happen if an out-of-tree module defines 
its own protocol within the Phonet family.

> Furthermore, -EINVAL is also returned when len < sizeof(struct sockaddr_pn),
> maybe the rebind case should return -EADDRINUSE instead of -EINVAL?

bind() semantics require returning EINVAL if the socket address size is, well, 
invalid.

If we are to distinguish the two error scenarii, then it's the rebind  case 
that needs a different error, but EINVAL is consistent with INET.

> I must be missing some things.

-- 
Rémi Denis-Courmont
Tapiolan uusi kaupunki, Uudenmaan tasavalta



