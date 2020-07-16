Return-Path: <SRS0=y5Sx=A3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C630CC433E4
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 15:26:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A6B5E2065F
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 15:26:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="s2mBrRQn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728934AbgGPP0V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jul 2020 11:26:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728435AbgGPP0U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jul 2020 11:26:20 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 983BCC061755;
        Thu, 16 Jul 2020 08:26:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:To:Subject:Sender:
        Reply-To:Cc:Content-ID:Content-Description;
        bh=+CiHfpUtVxMOjI6E4sB44pMgZZBOBvt/ruJyNsElp7o=; b=s2mBrRQngLOq6fUNAbdyWcTGne
        FCjo4db4g+yYf28mU0ByRFpVQaWKF0R/rNmU9izz8K0o81ZPvRar7TLmakHjrqKoRzxZAikj4pj12
        ZzZHTt6a3/pVxHUWyAr0uXBXMLgn/yrMt/mYr6PShimy3ZgHtbc3LKo07F1xE613ylzmTU/KUgdPY
        UVgC6DY4kBrCSeXOulUO+3EGkcEMpRS9biTOEsJdyGnYXBSKbTFUUGTzKF3jpVwyh8B/+Y0ATj78l
        A1eclcBCeU6CvRq2jsLj2Hn8aq00R/hNl2FHP/jO/0r78fkvCO13dHc4hKJw1rPbF9dIISEr7XVyX
        0tzu5nog==;
Received: from [2601:1c0:6280:3f0::19c2]
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jw5m4-0008L7-VU; Thu, 16 Jul 2020 15:26:17 +0000
Subject: Re: [PATCH 2/2] debugfs: Add access restriction option
To:     Peter Enderborg <peter.enderborg@sony.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>
References: <20200617133738.6631-1-peter.enderborg@sony.com>
 <20200716071511.26864-1-peter.enderborg@sony.com>
 <20200716071511.26864-3-peter.enderborg@sony.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <f76c104b-3f72-e76b-8fe6-5f5c3b0b2b2a@infradead.org>
Date:   Thu, 16 Jul 2020 08:26:12 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200716071511.26864-3-peter.enderborg@sony.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/16/20 12:15 AM, Peter Enderborg wrote:
> ---
>  .../admin-guide/kernel-parameters.txt         | 15 +++++++
>  fs/debugfs/inode.c                            | 39 +++++++++++++++++++
>  fs/debugfs/internal.h                         | 14 +++++++
>  lib/Kconfig.debug                             | 32 +++++++++++++++
>  4 files changed, 100 insertions(+)
> 

Hi Peter,
The changes look good. Thanks.

-- 
~Randy

