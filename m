Return-Path: <SRS0=f73W=7K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E3A0C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 17:40:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 198F0206DF
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 17:40:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cs.unc.edu header.i=@cs.unc.edu header.b="Gs95XU5o"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405634AbgE1RkW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 May 2020 13:40:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405580AbgE1RkU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 13:40:20 -0400
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FC6CC08C5C6
        for <linux-kernel@vger.kernel.org>; Thu, 28 May 2020 10:40:19 -0700 (PDT)
Received: by mail-qt1-x841.google.com with SMTP id x29so748919qtv.4
        for <linux-kernel@vger.kernel.org>; Thu, 28 May 2020 10:40:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cs.unc.edu; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=PwV3I/h9ECDK55LAKNKKbcQuL9ExS3G7llHSq4Tn6OA=;
        b=Gs95XU5o8voiR0MyzEnx3Pe1EHTIADOKs3x96D1pnBgK8IIPc4I7dTu9+jtsloXPi4
         hpWct0/+63vHQanp26kSh46Nmb9FgQ1dkblM+O/zlDYWHKMLhFAdArsoz7B0eyhM3pgp
         Lmmg1x5xyGpHTfZGD3veOfRZlxMiFjW8FD/MY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=PwV3I/h9ECDK55LAKNKKbcQuL9ExS3G7llHSq4Tn6OA=;
        b=p8Mb7TJTadNfEDFAAnMpnSGaATQo7B0e+OPNEFCiJCc9aRWVSjsxjmIh1T2K6yvnOy
         UwWW9LbQgu6Op41gHTcE613anX6h4kX63FYfUMw/t3mRQ/6CaCcnKgk/FrR8mOpULJl9
         HIK6OJqNYxV8Mr/K9/OVTOo+Zz5YL+2WwHLfzg0t1EroRhqC0aUNjiAjccDA0qivZXga
         9Y0i1xElT5q5WnfMLY1PTkZbFG/Z9x/fzgIR+qa4yvg+7MLJOq5hatMWWBv6yt69Ico6
         9uRl8/k6iC7g+iy50SnoScxkbFOpJjK7CdpdGfLpoyQ0NREIdZiTZGs8JGGZQ3YQVP2G
         g5uA==
X-Gm-Message-State: AOAM530f2johv2hxOilkqlsrTnJx1L+TK18sdqQlV3RfzAucUd/rp+c4
        AfnEBk79mVM8HvXftQe1wR2Jeg==
X-Google-Smtp-Source: ABdhPJw7fXFPO0x5h+WG2LE1CdLFAZBgy3kqvhe0DlhNL3pEuLp62K6IVw54/xei1v63L3zwbYJ62Q==
X-Received: by 2002:ac8:6bc1:: with SMTP id b1mr4336072qtt.65.1590687618729;
        Thu, 28 May 2020 10:40:18 -0700 (PDT)
Received: from pepe.local (71-142-124-255.lightspeed.rlghnc.sbcglobal.net. [71.142.124.255])
        by smtp.gmail.com with ESMTPSA id v1sm5318374qkb.19.2020.05.28.10.40.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 May 2020 10:40:18 -0700 (PDT)
Subject: Re: [PATCH v12 00/18] Enable FSGSBASE instructions
To:     Thomas Gleixner <tglx@linutronix.de>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     Andi Kleen <ak@linux.intel.com>, Sasha Levin <sashal@kernel.org>,
        linux-kernel@vger.kernel.org, bp@alien8.de, luto@kernel.org,
        hpa@zytor.com, dave.hansen@intel.com, tony.luck@intel.com,
        ravi.v.shankar@intel.com, chang.seok.bae@intel.com
References: <20200511045311.4785-1-sashal@kernel.org>
 <0186c22a8a6be1516df0703c421faaa581041774.camel@linux.intel.com>
 <20200515164013.GF29995@sasha-vm>
 <c566b89cc3ef6c164160cc56a820abac3fd70839.camel@linux.intel.com>
 <20200518153407.GA499505@tassilo.jf.intel.com>
 <371e6a92cad25cbe7a8489785efa7d3457ecef3b.camel@linux.intel.com>
 <87v9ksvoaq.fsf@nanos.tec.linutronix.de>
 <20200519164853.GA19706@linux.intel.com>
 <7eb45e02-03bf-0af0-c915-794bf49d66d7@cs.unc.edu>
 <87h7w7qy18.fsf@nanos.tec.linutronix.de>
 <c5fffcd1-c262-7046-a047-67de2bbccd78@cs.unc.edu>
 <87d06opd3a.fsf@nanos.tec.linutronix.de>
From:   Don Porter <porter@cs.unc.edu>
Message-ID: <e9a0a521-104b-5c3a-a689-78f878e73d31@cs.unc.edu>
Date:   Thu, 28 May 2020 13:40:16 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.8.1
MIME-Version: 1.0
In-Reply-To: <87d06opd3a.fsf@nanos.tec.linutronix.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thomas,

On 5/28/20 6:29 AM, Thomas Gleixner wrote:
>> Until recently, we were doing proof-of-concept research, not product
>> development, and there are limited hours in the day.  I also hasten to
>> say that the product of research is an article, the software artifact
>> serves as documentation of the experiment.  In contrast, the product of
>> software development is software.  It takes significant time and effort
>> to convert one to the other.  Upstreaming code is of little scientific
>> interest.  But things have changed for our project; we had no users in
>> 2015 and we are now un-cutting corners that are appropriate for research
>> but inappropriate for production.  For a research artifact with an
>> audience that knew the risks, we shipped a module because it was easier
>> to maintain and install than a kernel patch.
> 
> I understand that and with a big fat warning and documentation from
> start I wouldn't have complained so vehemently.

This is a fair point.  We will fix this ASAP, and I will be more careful 
about this going forward.

>
> Sorry for that innuendo. Now that my anger and general frustration about
> this whole disaster have calmed down, I surely would not write that
> again.

I appreciate you saying so.  Thank you.

I can also understand how frustrating the history was with this feature, 
and we missed an opportunity to help sooner.  There is a lot I still 
don't understand about the process of merging and testing patches in 
this community, but if it makes sense for us to help now, we would be 
willing.

-Don
