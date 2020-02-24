Return-Path: <SRS0=7TUr=4M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 773F9C38BE2
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 19:47:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 49CDD20656
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 19:47:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LaKg1j/G"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727197AbgBXTrx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Feb 2020 14:47:53 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:41399 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726593AbgBXTrw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Feb 2020 14:47:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1582573671;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=nnxs4S3V4j1u81O81rJrhpwntUjBUuBdMvRvoYKsH34=;
        b=LaKg1j/G9gGsl2G10l17H2sJ0owiEfVtPtL2XQpMEyYulxejBDOzVMBeJQMK71hOZ5FLUQ
        eoNTGysFJBKF0z8MTzTLhSoSFdANGDCxfoew9uwaK7XhnMzOk9zYDVcSdvO8c0wLFn7G6V
        rYPSVPNt+HGN1P74OucDJXsBY7AoR1o=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-145-UPehJHR9OAe72uxwGv7ctQ-1; Mon, 24 Feb 2020 14:47:50 -0500
X-MC-Unique: UPehJHR9OAe72uxwGv7ctQ-1
Received: by mail-ed1-f70.google.com with SMTP id y8so7407027edv.4
        for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2020 11:47:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nnxs4S3V4j1u81O81rJrhpwntUjBUuBdMvRvoYKsH34=;
        b=fYnPqdX66RFMVgD4o3+ae4FRzM6qsedHwp9pAtf2Htq1yFERirNOrzG5A7KLhnK+uw
         b4lfqsONS+VZxANSxC2V1vyuDY7pixwdQ4imL1wI+HkW2A2KUnH7DfoWftYEhlrrUb9W
         Q/qelziOUuOE0CSY3LTLEG+pOpY24BaQJKf9dkUbAfB96/JXg5dZdt+jqhnRbik0a4lK
         0bBCaW+LnB0dG3t1p/4CkZzF3m85jQ0wbEkM8lS2ofQoYxbetsBZc+NIAAtAvRrii3sX
         tHSOb7gtN3hMCOXkOGhxFopHmHQJAdhS8meiB03cTYbomGxWZAfrK7Z73ZGMneK2j+/A
         crjA==
X-Gm-Message-State: APjAAAW99QByIIVsuT/F43MaE6ANNNo/05BnjZXxFIh7eKRZSTqBPWgD
        krlUlZ0UbkNA1Nh6q3D8L9oU7CS3Htc27WrnvFw5sYDBc3mZk8P0QFre9Z/1usrZK8yZUh2RpXp
        gW+Jmpqh0W4tv/vvMAebEDaCrgCm1PVLiQ2NNhkgh
X-Received: by 2002:a17:906:ce57:: with SMTP id se23mr48387488ejb.362.1582573669116;
        Mon, 24 Feb 2020 11:47:49 -0800 (PST)
X-Google-Smtp-Source: APXvYqytTPwGRqhKju/NQPHj9LOagQ32SFVcrzvfbIgfGBW57jVwx7rncRDFd0C3JXVggWYL8tobRTZVXYqtNRKtLfc=
X-Received: by 2002:a17:906:ce57:: with SMTP id se23mr48387474ejb.362.1582573668885;
 Mon, 24 Feb 2020 11:47:48 -0800 (PST)
MIME-Version: 1.0
References: <20200224185529.50530-1-mcroce@redhat.com> <20200224191154.GH19559@breakpoint.cc>
 <CAGnkfhyUOyd1XWdSSxL844RG-_z32qGasV7a+2m7XNrS8qvtCw@mail.gmail.com>
In-Reply-To: <CAGnkfhyUOyd1XWdSSxL844RG-_z32qGasV7a+2m7XNrS8qvtCw@mail.gmail.com>
From:   Matteo Croce <mcroce@redhat.com>
Date:   Mon, 24 Feb 2020 20:47:13 +0100
Message-ID: <CAGnkfhzA6j2B43DFgQedeGE6H5XvHKWd7KPg3ocGVr0K_u2NJA@mail.gmail.com>
Subject: Re: [PATCH nf] netfilter: ensure rcu_read_lock() in ipv4_find_option()
To:     Florian Westphal <fw@strlen.de>
Cc:     netfilter-devel@vger.kernel.org, coreteam@netfilter.org,
        netdev <netdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        Jozsef Kadlecsik <kadlec@netfilter.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Stephen Suryaputra <ssuryaextr@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 24, 2020 at 8:42 PM Matteo Croce <mcroce@redhat.com> wrote:
>
> On Mon, Feb 24, 2020 at 8:12 PM Florian Westphal <fw@strlen.de> wrote:
> >
> > Matteo Croce <mcroce@redhat.com> wrote:
> > > As in commit c543cb4a5f07 ("ipv4: ensure rcu_read_lock() in ipv4_link_failure()")
> > > and commit 3e72dfdf8227 ("ipv4: ensure rcu_read_lock() in cipso_v4_error()"),
> > > __ip_options_compile() must be called under rcu protection.
> >
> > This is not needed, all netfilter hooks run with rcu_read_lock held.
> >
>
> Ok, so let's drop it, thanks.

What about adding a RCU_LOCKDEP_WARN() in __ip_options_compile() to
protect against future errors? Something like:

----------------------------------%<-------------------------------------
@@ -262,6 +262,9 @@ int __ip_options_compile(struct net *net,
  unsigned char *iph;
  int optlen, l;

+ RCU_LOCKDEP_WARN(!rcu_read_lock_held(),
+ __FUNC__ " needs rcu_read_lock() protection");
+
  if (skb) {
  rt = skb_rtable(skb);
  optptr = (unsigned char *)&(ip_hdr(skb)[1]);
---------------------------------->%-------------------------------------

Bye,
-- 
Matteo Croce
per aspera ad upstream

