Return-Path: <SRS0=pPEE=3I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8CB1C32771
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Jan 2020 01:44:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 945CC20679
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Jan 2020 01:44:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728826AbgASBoM convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Jan 2020 20:44:12 -0500
Received: from mx1.unisoc.com ([222.66.158.135]:21321 "EHLO
        SHSQR01.spreadtrum.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727083AbgASBoM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Jan 2020 20:44:12 -0500
Received: from ig2.spreadtrum.com (bjmbx01.spreadtrum.com [10.0.64.7])
        by SHSQR01.spreadtrum.com with ESMTPS id 00J1grHW050519
        (version=TLSv1 cipher=AES256-SHA bits=256 verify=NO);
        Sun, 19 Jan 2020 09:42:54 +0800 (CST)
        (envelope-from Orson.Zhai@unisoc.com)
Received: from lenovo (10.0.74.130) by BJMBX01.spreadtrum.com (10.0.64.7) with
 Microsoft SMTP Server (TLS) id 15.0.847.32; Sun, 19 Jan 2020 09:43:35 +0800
Date:   Sun, 19 Jan 2020 09:43:32 +0800
From:   Orson Zhai <orson.zhai@spreadtrum.com>
To:     Arnd Bergmann <arnd@arndb.de>, Lee Jones <lee.jones@linaro.org>
CC:     Lee Jones <lee.jones@linaro.org>,
        Orson Zhai <orson.zhai@unisoc.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        <baolin.wang@unisoc.com>, Chunyan Zhang <chunyan.zhang@unisoc.com>
Subject: Re: [PATCH v3] mfd: syscon: Add arguments support for syscon
 reference
Message-ID: <20200119014332.GH19966@lenovo>
References: <1579259812-27186-1-git-send-email-orson.zhai@unisoc.com>
 <20200117132807.GL15507@dell>
 <CAK8P3a3ApsUTpRYbpCtB-hHcsgtN0yyTOdTYOGUWw4woawH6vQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <CAK8P3a3ApsUTpRYbpCtB-hHcsgtN0yyTOdTYOGUWw4woawH6vQ@mail.gmail.com>
X-Originating-IP: [10.0.74.130]
X-ClientProxiedBy: SHCAS03.spreadtrum.com (10.0.1.207) To
 BJMBX01.spreadtrum.com (10.0.64.7)
Content-Transfer-Encoding: 8BIT
X-MAIL: SHSQR01.spreadtrum.com 00J1grHW050519
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnd and Lee,

I am so sorry about such inconvenience to you.
It was my fault!

There are some trailing spaces reported by checkpatch.
I forgot to scan one more time after the patch being revised.

V4 has been sent out, try one more time please.

Thank you very much!

Best Regards,
Orson

On Fri, Jan 17, 2020 at 03:54:09PM +0100, Arnd Bergmann wrote:
> On Fri, Jan 17, 2020 at 2:27 PM Lee Jones <lee.jones@linaro.org> wrote:
> >
> > On Fri, 17 Jan 2020, Orson Zhai wrote:
> >
> > > There are a lot of similar global registers being used across multiple SoCs
> > > from Unisoc. But most of these registers are assigned with different offset
> > > for different SoCs. It is hard to handle all of them in an all-in-one
> > > kernel image.
> > >
> > > Add a helper function to get regmap with arguments where we could put some
> > > extra information such as the offset value.
> > >
> > > Signed-off-by: Orson Zhai <orson.zhai@unisoc.com>
> > > Tested-by: Baolin Wang <baolin.wang@unisoc.com>
> > > Reviewed-by: Arnd Bergmann <arnd@arndb.de>
> > > Acked-by: Lee Jones <lee.jones@linaro.org>
> > > ---
> > >
> > > V3 Change:
> > >  Rebase on latest kernel v5.5-rc6 for Lee.
> >
> > Still not applying.
> >
> > I think it's a problem with the patch itself.
> >
> > It looks like all of the tabs have been replaced with spaces also.
> >
> > How are you sending the patch?
> >
> > Arnd,
> >
> >   Are you able to apply this?
>
> No, there appears to be some whitespace damage in the patch.
>
>       Arnd
________________________________
 This email (including its attachments) is intended only for the person or entity to which it is addressed and may contain information that is privileged, confidential or otherwise protected from disclosure. Unauthorized use, dissemination, distribution or copying of this email or the information herein or taking any action in reliance on the contents of this email or the information herein, by anyone other than the intended recipient, or an employee or agent responsible for delivering the message to the intended recipient, is strictly prohibited. If you are not the intended recipient, please do not read, copy, use or disclose any part of this e-mail to others. Please notify the sender immediately and permanently delete this e-mail and any attachments if you received it in error. Internet communications cannot be guaranteed to be timely, secure, error-free or virus-free. The sender does not accept liability for any errors or omissions.
本邮件及其附件具有保密性质，受法律保护不得泄露，仅发送给本邮件所指特定收件人。严禁非经授权使用、宣传、发布或复制本邮件或其内容。若非该特定收件人，请勿阅读、复制、 使用或披露本邮件的任何内容。若误收本邮件，请从系统中永久性删除本邮件及所有附件，并以回复邮件的方式即刻告知发件人。无法保证互联网通信及时、安全、无误或防毒。发件人对任何错漏均不承担责任。
