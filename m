Return-Path: <SRS0=EnQK=B5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46427C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 18:23:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1D77921775
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 18:23:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597861393;
	bh=qy/ZEjEhG1i+wvQPbJtGZ9T5kPpw8NHao4bG1dxNlns=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=0zaR1XR+YSRvwMzrVavHOXGM3MEV5ysC+2OIbLuDNBqru64aOOZkvhpgtiODR/o1o
	 8vA5fhKE4Kk0j8RliqWo2d6+TsZZ3SHNMVaLhdpm1saZGFTlLbMH7f7LAIM1p5ygNL
	 Cpn+D6+sW1CVI+JaPn34DQPoKDGnm85h45Bjd5KY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726806AbgHSSXL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Aug 2020 14:23:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:47076 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726646AbgHSSXJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Aug 2020 14:23:09 -0400
Received: from pali.im (pali.im [31.31.79.79])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AB6BE20758;
        Wed, 19 Aug 2020 18:23:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597861388;
        bh=qy/ZEjEhG1i+wvQPbJtGZ9T5kPpw8NHao4bG1dxNlns=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JPzbGLOI8lD/e6rSmRoXD3w+zE23xhVb8yRK2e9oKUHzr8OR98pJFBbBmA0Nj2Aiy
         cZW+xhiPKr9jpgAH2uRYwykye0AJi+f8RkpVzVNL9NOGgf4Ek+/Bm25GGJqmXmDI2j
         r3FExyclO1T94xuXOTBfHDN8iugHJ72WxtziqkXg=
Received: by pali.im (Postfix)
        id 9552E582; Wed, 19 Aug 2020 20:23:06 +0200 (CEST)
Date:   Wed, 19 Aug 2020 20:23:06 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     Joseph Hwang <josephsih@chromium.org>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Joseph Hwang <josephsih@google.com>,
        ChromeOS Bluetooth Upstreaming 
        <chromeos-bluetooth-upstreaming@chromium.org>,
        Alain Michaud <alainm@chromium.org>,
        Abhishek Pandit-Subedi <abhishekpandit@chromium.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:NETWORKING [GENERAL]" <netdev@vger.kernel.org>
Subject: Re: [PATCH v1 2/2] Bluetooth: sco: expose WBS packet length in
 socket option
Message-ID: <20200819182306.wvyht6ocyqpo75tp@pali>
References: <20200813084129.332730-1-josephsih@chromium.org>
 <20200813164059.v1.2.I03247d3813c6dcbcdbeab26d068f9fd765edb1f5@changeid>
 <CABBYNZJ-nBXeujF2WkMEPYPQhXAphqKCV39gr-QYFdTC3GvjXg@mail.gmail.com>
 <20200819143716.iimo4l3uul7lrpjn@pali>
 <CABBYNZJVDk6LWqyY7h8=KwpA4Oub+aCb3WEWnxk_AGWPvgmatg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABBYNZJVDk6LWqyY7h8=KwpA4Oub+aCb3WEWnxk_AGWPvgmatg@mail.gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 19 August 2020 11:21:00 Luiz Augusto von Dentz wrote:
> Hi Pali,
> 
> On Wed, Aug 19, 2020 at 7:37 AM Pali Rohár <pali@kernel.org> wrote:
> >
> > On Friday 14 August 2020 12:56:05 Luiz Augusto von Dentz wrote:
> > > Hi Joseph,
> > >
> > > On Thu, Aug 13, 2020 at 1:42 AM Joseph Hwang <josephsih@chromium.org> wrote:
> > > >
> > > > It is desirable to expose the wideband speech packet length via
> > > > a socket option to the user space so that the user space can set
> > > > the value correctly in configuring the sco connection.
> > > >
> > > > Reviewed-by: Alain Michaud <alainm@chromium.org>
> > > > Reviewed-by: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
> > > > Signed-off-by: Joseph Hwang <josephsih@chromium.org>
> > > > ---
> > > >
> > > >  include/net/bluetooth/bluetooth.h | 2 ++
> > > >  net/bluetooth/sco.c               | 8 ++++++++
> > > >  2 files changed, 10 insertions(+)
> > > >
> > > > diff --git a/include/net/bluetooth/bluetooth.h b/include/net/bluetooth/bluetooth.h
> > > > index 9125effbf4483d..922cc03143def4 100644
> > > > --- a/include/net/bluetooth/bluetooth.h
> > > > +++ b/include/net/bluetooth/bluetooth.h
> > > > @@ -153,6 +153,8 @@ struct bt_voice {
> > > >
> > > >  #define BT_SCM_PKT_STATUS      0x03
> > > >
> > > > +#define BT_SCO_PKT_LEN         17
> > > > +
> > > >  __printf(1, 2)
> > > >  void bt_info(const char *fmt, ...);
> > > >  __printf(1, 2)
> > > > diff --git a/net/bluetooth/sco.c b/net/bluetooth/sco.c
> > > > index dcf7f96ff417e6..97e4e7c7b8cf62 100644
> > > > --- a/net/bluetooth/sco.c
> > > > +++ b/net/bluetooth/sco.c
> > > > @@ -67,6 +67,7 @@ struct sco_pinfo {
> > > >         __u32           flags;
> > > >         __u16           setting;
> > > >         __u8            cmsg_mask;
> > > > +       __u32           pkt_len;
> > > >         struct sco_conn *conn;
> > > >  };
> > > >
> > > > @@ -267,6 +268,8 @@ static int sco_connect(struct sock *sk)
> > > >                 sco_sock_set_timer(sk, sk->sk_sndtimeo);
> > > >         }
> > > >
> > > > +       sco_pi(sk)->pkt_len = hdev->sco_pkt_len;
> > > > +
> > > >  done:
> > > >         hci_dev_unlock(hdev);
> > > >         hci_dev_put(hdev);
> > > > @@ -1001,6 +1004,11 @@ static int sco_sock_getsockopt(struct socket *sock, int level, int optname,
> > > >                         err = -EFAULT;
> > > >                 break;
> > > >
> > > > +       case BT_SCO_PKT_LEN:
> > > > +               if (put_user(sco_pi(sk)->pkt_len, (u32 __user *)optval))
> > > > +                       err = -EFAULT;
> > > > +               break;
> > >
> > > Couldn't we expose this via BT_SNDMTU/BT_RCVMTU?
> >
> > Hello!
> >
> > There is already SCO_OPTIONS sock option, uses struct sco_options and
> > contains 'mtu' member.
> >
> > I think that instead of adding new sock option, existing SCO_OPTIONS
> > option should be used.
> 
> We are moving away from type specific options to so options like
> BT_SNDMTU/BT_RCVMTU should be supported in all socket types.

Yes, this make sense.

But I guess that SCO_OPTIONS should be provided for backward
compatibility as it is already used by lot of userspace applications.

So for me it looks like that BT_SNDMTU/BT_RCVMTU should return same
value as SCO_OPTIONS.

> >
> > > >         default:
> > > >                 err = -ENOPROTOOPT;
> > > >                 break;
> > > > --
> > > > 2.28.0.236.gb10cc79966-goog
> > > >
> > >
> > >
> > > --
> > > Luiz Augusto von Dentz
> 
> 
> 
> -- 
> Luiz Augusto von Dentz
