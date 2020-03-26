Return-Path: <SRS0=aGSP=5L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F0C8C2D0E5
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 21:13:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF38320719
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 21:13:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727909AbgCZVNY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Mar 2020 17:13:24 -0400
Received: from s3.sipsolutions.net ([144.76.43.62]:55492 "EHLO
        sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726330AbgCZVNY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Mar 2020 17:13:24 -0400
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.93)
        (envelope-from <johannes@sipsolutions.net>)
        id 1jHZoW-00CMAL-OE; Thu, 26 Mar 2020 22:13:21 +0100
Message-ID: <0db3e8c07fd6a9ec933d62cb045b181d7c832d90.camel@sipsolutions.net>
Subject: Re: [PATCH] kernel/taskstats: fix wrong nla type for
 {cgroup,task}stats policy
From:   Johannes Berg <johannes@sipsolutions.net>
To:     David Ahern <dsahern@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Yafang Shao <laoar.shao@gmail.com>
Cc:     bsingharora@gmail.com, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org, "David S.Miller" <davem@davemloft.net>
Date:   Thu, 26 Mar 2020 22:13:19 +0100
In-Reply-To: <ed7c4063-8b45-9fc8-5b92-a903d9da4054@gmail.com> (sfid-20200326_221130_152472_BA2B584D)
References: <1585191042-9935-1-git-send-email-laoar.shao@gmail.com>
         <20200326130808.ccbacd6cba99a40326936fea@linux-foundation.org>
         <b879b50324b502cbd3f8439182d63532518d7315.camel@sipsolutions.net>
         <ed7c4063-8b45-9fc8-5b92-a903d9da4054@gmail.com>
         (sfid-20200326_221130_152472_BA2B584D)
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 (3.34.4-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2020-03-26 at 15:11 -0600, David Ahern wrote:
> 
> >         na->nla_len = nla_len + 1 + NLA_HDRLEN;
> > 
> > // but this??? the nla_len of a netlink attribute should just be
> > // the len ... what's NLA_HDRLEN doing here? this isn't nested
> > // here we end up just reserving 1+NLA_HDRLEN too much space

[...]

> I do not get the error message with this change as Johannes points out
> above:
> 
> diff --git a/tools/accounting/getdelays.c b/tools/accounting/getdelays.c
> index 8cb504d30384..e90fd133df0e 100644
> --- a/tools/accounting/getdelays.c
> +++ b/tools/accounting/getdelays.c
> @@ -136,7 +136,7 @@ static int send_cmd(int sd, __u16 nlmsg_type, __u32
> nlmsg_pid,
>         msg.g.version = 0x1;
>         na = (struct nlattr *) GENLMSG_DATA(&msg);
>         na->nla_type = nla_type;
> -       na->nla_len = nla_len + 1 + NLA_HDRLEN;
> +       na->nla_len = nla_len + NLA_HDRLEN;

Oops, thanks for the correction - indeed NLA_HDRLEN is included, I was
wrong above.

johannes

