Return-Path: <SRS0=7RkH=3E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B1C8C33CB1
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 04:52:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 302F9214AF
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 04:52:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729012AbgAOEwf convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jan 2020 23:52:35 -0500
Received: from sci-ig2.spreadtrum.com ([222.66.158.135]:35443 "EHLO
        SHSQR01.spreadtrum.com" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728890AbgAOEwf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jan 2020 23:52:35 -0500
Received: from ig2.spreadtrum.com (bjmbx01.spreadtrum.com [10.0.64.7])
        by SHSQR01.spreadtrum.com with ESMTPS id 00F4pebM077255
        (version=TLSv1 cipher=AES256-SHA bits=256 verify=NO);
        Wed, 15 Jan 2020 12:51:40 +0800 (CST)
        (envelope-from Orson.Zhai@unisoc.com)
Received: from lenovo (10.0.74.130) by BJMBX01.spreadtrum.com (10.0.64.7) with
 Microsoft SMTP Server (TLS) id 15.0.847.32; Wed, 15 Jan 2020 12:52:03 +0800
Date:   Wed, 15 Jan 2020 12:51:55 +0800
From:   Orson Zhai <orson.zhai@spreadtrum.com>
To:     Lee Jones <lee.jones@linaro.org>
CC:     Rob Herring <robh@kernel.org>, Orson Zhai <orson.zhai@unisoc.com>,
        Arnd Bergmann <arnd@arndb.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        <baolin.wang@unisoc.com>, <kevin.tang@unisoc.com>,
        Chunyan Zhang <chunyan.zhang@unisoc.com>,
        <liangcai.fan@unisoc.com>, <orsonzhai@gmail.com>
Subject: Re: [PATCH v3] mfd: syscon: Add arguments support for syscon
 reference
Message-ID: <20200115045155.GE19966@lenovo>
References: <1576037311-6052-1-git-send-email-orson.zhai@unisoc.com>
 <CAK8P3a0244jKrEop2rHVyJZ57h4A9+mqb-5g-wLUSfR2G1svwg@mail.gmail.com>
 <20191213024935.GD9271@lenovo>
 <20191213082336.GD3468@dell>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <20191213082336.GD3468@dell>
X-Originating-IP: [10.0.74.130]
X-ClientProxiedBy: SHCAS03.spreadtrum.com (10.0.1.207) To
 BJMBX01.spreadtrum.com (10.0.64.7)
X-MAIL: SHSQR01.spreadtrum.com 00F4pebM077255
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Lee,

Don't forget to apply this patch please :)

Feel free to ask me if any problem.

Best,
Orson

On Fri, Dec 13, 2019 at 08:23:36AM +0000, Lee Jones wrote:
> On Fri, 13 Dec 2019, Orson Zhai wrote:
>
> > Hi Lee and Rob,
> >
> > On Wed, Dec 11, 2019 at 02:55:39PM +0100, Arnd Bergmann wrote:
> > > On Wed, Dec 11, 2019 at 5:09 AM Orson Zhai <orson.zhai@unisoc.com> wrote:
> > > >
> > > > There are a lot of similar global registers being used across multiple SoCs
> > > > from Unisoc. But most of these registers are assigned with different offset
> > > > for different SoCs. It is hard to handle all of them in an all-in-one
> > > > kernel image.
> > > >
> > > > Add a helper function to get regmap with arguments where we could put some
> > > > extra information such as the offset value.
> > > >
> > > > Signed-off-by: Orson Zhai <orson.zhai@unisoc.com>
> > > > Tested-by: Baolin Wang <baolin.wang@unisoc.com>
> > >
> > > Reviewed-by: Arnd Bergmann <arnd@arndb.de>
> >
> > Does this patch look good to be applied?
> >
> > Or if any comments please feel free to send to me.
>
> If it looks good to Arnd, it looks good to me.
>
> I have quite a number of reviews to get through first though, please
> bear with me and resist the urge to nag.
>
> --
> Lee Jones [李琼斯]
> Linaro Services Technical Lead
> Linaro.org │ Open source software for ARM SoCs
> Follow Linaro: Facebook | Twitter | Blog
________________________________
 This email (including its attachments) is intended only for the person or entity to which it is addressed and may contain information that is privileged, confidential or otherwise protected from disclosure. Unauthorized use, dissemination, distribution or copying of this email or the information herein or taking any action in reliance on the contents of this email or the information herein, by anyone other than the intended recipient, or an employee or agent responsible for delivering the message to the intended recipient, is strictly prohibited. If you are not the intended recipient, please do not read, copy, use or disclose any part of this e-mail to others. Please notify the sender immediately and permanently delete this e-mail and any attachments if you received it in error. Internet communications cannot be guaranteed to be timely, secure, error-free or virus-free. The sender does not accept liability for any errors or omissions.
本邮件及其附件具有保密性质，受法律保护不得泄露，仅发送给本邮件所指特定收件人。严禁非经授权使用、宣传、发布或复制本邮件或其内容。若非该特定收件人，请勿阅读、复制、 使用或披露本邮件的任何内容。若误收本邮件，请从系统中永久性删除本邮件及所有附件，并以回复邮件的方式即刻告知发件人。无法保证互联网通信及时、安全、无误或防毒。发件人对任何错漏均不承担责任。
