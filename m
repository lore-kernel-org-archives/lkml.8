Return-Path: <SRS0=Mt+e=5P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE093C43331
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 12:25:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A36F220675
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 12:25:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G9gm5VGh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730073AbgC3MZ1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Mar 2020 08:25:27 -0400
Received: from mail-pj1-f50.google.com ([209.85.216.50]:50415 "EHLO
        mail-pj1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729957AbgC3MZZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Mar 2020 08:25:25 -0400
Received: by mail-pj1-f50.google.com with SMTP id v13so7490645pjb.0;
        Mon, 30 Mar 2020 05:25:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=M8Ib8l/azcsofbPAguA4h7SVkMzxDl6gmT98v4wG9GU=;
        b=G9gm5VGhAArsT1CmH0uZY313vNbbuauBelRohmp7x0E53WwYgN/yccZmdD8/HLYLOH
         QNR3fLWxNp4efa/CbHkkioW639eQ4pDkZyx4273q2vNQDsvfYCtsJfaPd77RdPFN4UJU
         Pbz6VhGx8Sea6HgnZx+91WIAZtt3nsPL1wNM9PTfBuqTb+t5PQZvLU7DE8raWG7Y3SLJ
         vatFluJWaku6PJd4umh4j/XcN2Md/EH5Cw52K0MPNVaBtDJCrvxJopDGwtTmOLHkzzqe
         LV0timV5SbWDLmNNihgpriN5KPTXtdKEsVWM37zhFnNaB9s8EZornHbjbfkfhMrWKM0K
         YedQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=M8Ib8l/azcsofbPAguA4h7SVkMzxDl6gmT98v4wG9GU=;
        b=Stgg/L1UpZhyIHXJAlrhP4WdyAWdJ1dmvU9yxDbyyZGOlVJQJHr9iIyjmiwHiLpAMj
         Pfswd++Oe5ZZ3ZbcpoYNtJsbQlXglYXOEhLUxH3FnUneKxgYUfCsLlUH9Eef6VbT5AeF
         efxkYVB1lTgViPkKFl5iJBLZdWl71oDilZO4Bn8vx9u1Bh0D8wCSc89ZPDQosJrlotAp
         PI2mWe9rRWlChvzv75hq9GfubgOA66H4lNl7zS1SYU801AGLCeBzuSYeAYh5kRbO2vuz
         fatwToHu8CGoFNcWDo2zMggDtPcqZtWjEU1in1+ABPUfoJeMZpZGB9RqiwG71yGAjy2j
         VCFw==
X-Gm-Message-State: AGi0PuavyBKKB454+YaXqIdyrA2X4KPdyKDBrJCblq2dhrbuzXGa6tQm
        70lZ5Gbmz6F/Fm36Z66nog==
X-Google-Smtp-Source: APiQypIIPYL8VmKnr+it9nYOPnlJhYJLIQV+SCGDeBZlqWZi/xj1JPMh5SXdsGM/hAWpeOl7hubg1w==
X-Received: by 2002:a17:90b:400a:: with SMTP id ie10mr8001144pjb.46.1585571124433;
        Mon, 30 Mar 2020 05:25:24 -0700 (PDT)
Received: from madhuparna-HP-Notebook ([2402:3a80:d3b:3d6b:7942:93fd:fd15:96f0])
        by smtp.gmail.com with ESMTPSA id y17sm10044862pfl.104.2020.03.30.05.25.20
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 30 Mar 2020 05:25:23 -0700 (PDT)
From:   Madhuparna Bhowmik <madhuparnabhowmik10@gmail.com>
X-Google-Original-From: Madhuparna Bhowmik <change_this_user_name@gmail.com>
Date:   Mon, 30 Mar 2020 17:55:18 +0530
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     madhuparnabhowmik10@gmail.com, hariprasad.kelam@gmail.com,
        colin.king@canonical.com, tony.olech@elandigitalsystems.com,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        andrianov@ispras.ru
Subject: Re: Possible data-race related bug in u132_hcd module.
Message-ID: <20200330122518.GA12077@madhuparna-HP-Notebook>
References: <20200330115243.11107-1-madhuparnabhowmik10@gmail.com>
 <20200330120207.GA2807@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200330120207.GA2807@kroah.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 30, 2020 at 02:02:07PM +0200, Greg KH wrote:
> On Mon, Mar 30, 2020 at 05:22:43PM +0530, madhuparnabhowmik10@gmail.com wrote:
> > Hi,
> > 
> > This bug is found by  Linux Driver Verification project (linuxtesting.org).
> > 
> > The bug is related to the parallel execution of u132_probe() function and u132_hcd_exit() function in u132_hcd.c. In case the module is unloaded when the probe function is executing there can be data race as the mutex lock u132_module_lock is not used properly. 
> 
> Please note that module unloading, while a nice thing to have, is never
> something that happens automatically :)
> 
> > i) Usage of mutex lock only when writing into the u132_exiting variable in u132_hcd_exit(). The lock is not used when this variable is read in u132_probe().
> > 
> > Moreover, this variable does not serve its purpose, as even if locking is used while the u132_exiting variable is read in probe(), the function may still miss that exit function is executing if it acquires the mutex before exit() function does.
> > 
> > How to fix this?
> > 
> > ii) Usage of mutex while adding entries in u132_static_list in probe function but not in exit function while unregistering.
> > This should be easy to fix by holding the mutex in the exit function as well.
> > 
> > There can be other synchronization problems related to the usage of u132_module_lock in this module, I have only spotted these so far.
> > 
> > Please let me know if this bug report is helpful and I can send a patch fixing it.
> 
> Please just send a patch, no need to ever ask if you should, that's the
> best way to report and fix anything.
>
Sure, I will do it.

Thank you,
Madhuparna

> thanks,
> 
> greg k-h
