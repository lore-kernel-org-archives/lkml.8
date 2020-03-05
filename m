Return-Path: <SRS0=j27y=4W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62095C3F2D7
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 16:06:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 345C32073B
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 16:06:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="l0SbPoqH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726973AbgCEQGp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Mar 2020 11:06:45 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:39668 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726359AbgCEQGo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Mar 2020 11:06:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description;
        bh=OelL0+sWRwbd3cE6rtMnf8MQ2r2pf+ox8uliO1C/bLU=; b=l0SbPoqHPwOW/A5gzvOvPNwmhE
        EGMaudbOoPJVAaL0ZEP+gAaORjitUSs0XzZLzWZbHyHL7kY2QxQuOFE1yH1jTTlTyIvZ6TCLCB5G/
        U9tYa8cT/c34P/XoE4i61lVAfpuKbbU3I2WF2Q2q+1hqF4v6s8X+IuV12ZPP4EjqBHeAKsNYqFYO1
        XhD3Szen6QzvefodRkLHStC1WWCzzCwFf6h8ek8m3fIn4gMvipASYRMeBMXNGnTTxf+eNVQuQKCo3
        vH++4arV+53zZvVW/0Yl9Ck0EPK0kzvFn0DtkqKxelBlRR3/M86lnMSN5/2O6oijGQha8xgoFZTGf
        cD/HeKGQ==;
Received: from [2601:1c0:6280:3f0:897c:6038:c71d:ecac]
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j9t1G-0003YR-Hc; Thu, 05 Mar 2020 16:06:42 +0000
Subject: Re: [v5] Documentation: bootconfig: Update boot configuration
 documentation
To:     Markus Elfring <Markus.Elfring@web.de>, linux-doc@vger.kernel.org
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-kernel@vger.kernel.org
References: <158339065180.26602.26457588086834858.stgit@devnote2>
 <158339066140.26602.7533299987467005089.stgit@devnote2>
 <ef820445-25c5-a312-57d4-25ff3b4d08cf@infradead.org>
 <3fb124a6-07d2-7a40-8981-07561aeb3c1e@web.de>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <f823204d-dcd1-2159-a525-02f15562e1af@infradead.org>
Date:   Thu, 5 Mar 2020 08:06:40 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <3fb124a6-07d2-7a40-8981-07561aeb3c1e@web.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/5/20 1:33 AM, Markus Elfring wrote:
>> Reviewed-by: Randy Dunlap <rdunlap@infradead.org>
> 
> How does this feedback fit to known concerns around the discussed wordings?

As far as I am concerned, it means that the documentation is
sufficiently good enough to be useful and not difficult to read.

It does not mean that it's perfect. Patches can still be made to it.

-- 
~Randy

