Return-Path: <SRS0=j27y=4W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC3A5C3F2D2
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 16:07:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 831E2208CD
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 16:07:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="PqzqkzzN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726889AbgCEQH4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Mar 2020 11:07:56 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:40088 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725946AbgCEQHz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Mar 2020 11:07:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description;
        bh=oRpN9V27jhtzsKj/qs2uwo3l+QHMiu1tvikChVvD9ZU=; b=PqzqkzzN3/awFcPvvV+89xWhio
        CCEDJ2/hgmsgijR4R1ZipBOuEO0Zh6jVDq4UWOSbgSTnWes1B8SANTgtjuKkCHlEyukeA8/FdV2Tw
        +ePx25wp2aNtLwtljdySmOBpJURci+NtjZZEBuFNoqKDaHM2cewevuxnN5DzW8GWj1kccGlclo9ed
        rtdy9cbhAOggZ2U4ToEydmRRD0IdPyhYhjoo3VmfELeG27l7hmfU7EkfbQMyCJd+81gz+kHj6Wlmq
        XKFkUjZtGvMH1SspogQvmIEqsSgCFUXzSitWG71N0KXDevzDXY2Jk9/MkPyf1SQcXyQ8fhzmzDIW9
        yAgV9yKg==;
Received: from [2601:1c0:6280:3f0:897c:6038:c71d:ecac]
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j9t2R-0003iE-Br; Thu, 05 Mar 2020 16:07:55 +0000
Subject: Re: [PATCH v5] Documentation: bootconfig: Update boot configuration
 documentation
To:     Markus Elfring <Markus.Elfring@web.de>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        linux-doc@vger.kernel.org
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-kernel@vger.kernel.org
References: <158339065180.26602.26457588086834858.stgit@devnote2>
 <158339066140.26602.7533299987467005089.stgit@devnote2>
 <967d6fee-e0cd-c53f-c1f6-b367a979762c@web.de>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <f70d39ae-49ab-9b85-31a7-18609feb9ff8@infradead.org>
Date:   Thu, 5 Mar 2020 08:07:54 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <967d6fee-e0cd-c53f-c1f6-b367a979762c@web.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/5/20 2:19 AM, Markus Elfring wrote:
> …
>> +++ b/Documentation/admin-guide/bootconfig.rst
> …
>>  … word must contain only alphabets, numbers, …
> 
> Would the wording “… alphanumeric characters …” be nicer?

Sure.

-- 
~Randy

