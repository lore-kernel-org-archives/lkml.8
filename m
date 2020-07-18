Return-Path: <SRS0=rxDU=A5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF24FC433DF
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Jul 2020 18:19:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AA7CB2073A
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Jul 2020 18:19:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cs.unc.edu header.i=@cs.unc.edu header.b="BjePOPNu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727025AbgGRST5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Jul 2020 14:19:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726155AbgGRST4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Jul 2020 14:19:56 -0400
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CDA4C0619D2
        for <linux-kernel@vger.kernel.org>; Sat, 18 Jul 2020 11:19:56 -0700 (PDT)
Received: by mail-qk1-x736.google.com with SMTP id c139so11685613qkg.12
        for <linux-kernel@vger.kernel.org>; Sat, 18 Jul 2020 11:19:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cs.unc.edu; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=CPHxYEINn6fP/NPNQFcYh/XkOGxTPJZRwYyfvsYz3Uo=;
        b=BjePOPNuBiA85sqooXKZ3EVTDUDEe8BSYuYpaCOvuqE2joS6X6Ue3wRHS6i2wtjABD
         2akEbA/Mms2RXtiuyAxLkQRXUxOIeMKJmUx6K2cvJfYI3RcP5iCCa6GnQP8ZmPT0HSR4
         ydkVZFJZJUckKrGYh5ss+jlTIhSBUdsqTpojw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=CPHxYEINn6fP/NPNQFcYh/XkOGxTPJZRwYyfvsYz3Uo=;
        b=RjzjaKYtDC3vqHE9q3bq1wkwezwZVFmzDIX83tr2CphnPC6+Tsf5TZup66BiqfZ3Iu
         lQ2Q4Ytm6AmBKyu/bWP7Dnk8/AAK78Jgi+CwTRXNBFKub8tqlq4KiDTOfdYk5LRBwIFV
         ZXIt3ABDcNH5pGnGO7i9xHQ9OOOVRRRxQZ8Gqf4c1f+SqgRS5vOcJdhAisuWCg4lhbJX
         sDGVxK5uH6gcPhpBOSW6/n28gnYqQce/LEhvPLIZjhApvHv2FvM3iQ++oUUL/hdl5CRq
         Ce9kBtJvELewA3740+Sv8sDGp7I/rTcKlJnt7pVyXPEs0LgkiV++dSGmpQJgteU4Fbkc
         T22g==
X-Gm-Message-State: AOAM530xPZ9aG5IU6F+Jqzjq1A3JslYWUa2aSLxFRC4lSVQdAc9xr3vh
        SPhX1KSlIdbz9fjL3z8/SwiUeA==
X-Google-Smtp-Source: ABdhPJykjgUvXlpcIDTohsO9lUTdzQN4Qai52aGwBdx5EV9ecm3I+HB+eU5/29slhTly0QvgbkkYDA==
X-Received: by 2002:a37:aa03:: with SMTP id t3mr14630022qke.152.1595096394147;
        Sat, 18 Jul 2020 11:19:54 -0700 (PDT)
Received: from pepe.local (71-142-124-255.lightspeed.rlghnc.sbcglobal.net. [71.142.124.255])
        by smtp.gmail.com with ESMTPSA id h197sm13509008qke.51.2020.07.18.11.19.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 18 Jul 2020 11:19:53 -0700 (PDT)
Subject: Re: [PATCH v12 00/18] Enable FSGSBASE instructions
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     Andy Lutomirski <luto@amacapital.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andi Kleen <ak@linux.intel.com>,
        Sasha Levin <sashal@kernel.org>, linux-kernel@vger.kernel.org,
        bp@alien8.de, luto@kernel.org, hpa@zytor.com,
        dave.hansen@intel.com, tony.luck@intel.com,
        ravi.v.shankar@intel.com, chang.seok.bae@intel.com
References: <e9a0a521-104b-5c3a-a689-78f878e73d31@cs.unc.edu>
 <7A3EBAB0-B3B3-4CB7-AA6A-FDF29D03E30D@amacapital.net>
 <20200529152756.GA7452@invisiblethingslab.com>
 <ef8bbdff-e891-bee3-677d-3606474ecc10@cs.unc.edu>
 <20200625213705.GF20341@linux.intel.com>
From:   Don Porter <porter@cs.unc.edu>
Message-ID: <a6e45675-a7f0-7708-6cc6-318a947e2e57@cs.unc.edu>
Date:   Sat, 18 Jul 2020 14:19:52 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200625213705.GF20341@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/25/20 5:37 PM, Jarkko Sakkinen wrote:
> 
> Can unmodified Graphene-SGX used with these changes?
> 

Yes.  I just double-checked that all of the needed changes have made it 
to master branch.

I also re-tested on 5.8-rc1 with v13 of the patch, and it looks good.
