Return-Path: <SRS0=eufF=BE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FAF9C433E8
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Jul 2020 10:21:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 402BA206EB
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Jul 2020 10:21:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595672476;
	bh=4fB3ZwogdcdVPIDLLsbHLV1b+WfAbVyxUhEIUsq9urw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=kB9qfLEH8Obbk2t4HbXjwr9IAjZJeSWmkx2T3IVELmkGw/3MvjcLmOt2SabyMrSyf
	 LNgkT3N36LstmiNutdGwGeIkwIfPTjp2qRfyBVGiWSt2IiZzVI/W81IpoFO2fEAKrt
	 QRd2SdRP+EYGx+Mc8LT95qayhOun48DppUVqq014=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726711AbgGYKVP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 Jul 2020 06:21:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726572AbgGYKVO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Jul 2020 06:21:14 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F7E4C0619D3
        for <linux-kernel@vger.kernel.org>; Sat, 25 Jul 2020 03:21:14 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id lx13so12390650ejb.4
        for <linux-kernel@vger.kernel.org>; Sat, 25 Jul 2020 03:21:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=missdBsNUzT7ukHWexKwYjiaX2t9R6jTrHE5vOnris8=;
        b=fCRC7859xWOSbmhU4JKMCe+akFDWIyPM7HAKB7nU55UPjnpS/tGtO7rZE+MhfZB0Bt
         8U8Wz/5zhFEDQfnQH8/dZhyml4+1go+4t2QL13eB53s1B3OgARiKuu0ARZrm4ZVZMAvG
         pqUh3m+EzE04nIceDtofchMlX3oNWsSqEDUrd6tZlexJw85bhjKQ30Tqu4D0FUtrJG1+
         /DCqtBGF0sp3p1Gqh92PRQ/SUEpgqaOfBY1NSn/fcLC7rzifhOmIoIjLlm76s/Zp0H7I
         fNVMy1K/Naw5Q08yS5vesNwJnwxu0iuONkI4J9Dt2RccNkL/6ynBNcCgJwfFxkTy56yD
         MFTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=missdBsNUzT7ukHWexKwYjiaX2t9R6jTrHE5vOnris8=;
        b=CZ3xZXfPkDX8eIgZsUVPFIukqds1ZI2jKWcVRIWeG2bqaP2m7I9UunQhVPheaQKOMQ
         M6NQD0w1TUKUfv4xtvnFJqREveauhQRpjBOA2/j9h24xtqLJu1sJVIF0zaxtezw6zEDb
         9ELFGZeqE5d6fUB+6ZmaCL/yHWRjC6kXXb1gr+e4kFnTTH1TKrMv6qLLGfCmLQ8va+nC
         TQMvp4XB3qm2E2ZoRrCS5IIDSBtSVr5lC43C5DIHXiQdGagYqecOihsD4+yah/3/IuDg
         n4qatA94aLLJlPni48OJhqoAz4cUoBVsYOjC+kEUIXGDASd+XqnS2UFnxyv+x5ulkuvC
         A04g==
X-Gm-Message-State: AOAM532fwj6D8ZPug2etGUrEMqch7rHgdScMec6RApYJUsFgzVlBz1UO
        6OC/4Eqjwr6QYD6Zghc5QRhE07SN
X-Google-Smtp-Source: ABdhPJx407E1T3MUmslE6VBYvrrgVuh+hSPQmhXYtTVqRvBkBBl4j1YkzdCwe9/0Qjrceq6yTr7DKg==
X-Received: by 2002:a17:906:8595:: with SMTP id v21mr13457349ejx.333.1595672473007;
        Sat, 25 Jul 2020 03:21:13 -0700 (PDT)
Received: from gmail.com (54033286.catv.pool.telekom.hu. [84.3.50.134])
        by smtp.gmail.com with ESMTPSA id i7sm2605033eds.91.2020.07.25.03.21.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Jul 2020 03:21:12 -0700 (PDT)
Date:   Sat, 25 Jul 2020 12:21:10 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Andi Kleen <ak@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Jessica Yu <jeyu@kernel.org>,
        "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
        Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>
Subject: Re: [PATCH v5 1/6] kprobes: Remove dependency to the module_mutex
Message-ID: <20200725102110.GA757173@gmail.com>
References: <20200724050553.1724168-1-jarkko.sakkinen@linux.intel.com>
 <20200724050553.1724168-2-jarkko.sakkinen@linux.intel.com>
 <20200724091711.GB517988@gmail.com>
 <20200725030107.GF17052@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200725030107.GF17052@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com> wrote:

> On Fri, Jul 24, 2020 at 11:17:11AM +0200, Ingo Molnar wrote:
> > 
> > * Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com> wrote:
> > 
> > > --- a/kernel/kprobes.c
> > > +++ b/kernel/kprobes.c
> > > @@ -564,7 +564,7 @@ static void kprobe_optimizer(struct work_struct *work)
> > >  	cpus_read_lock();
> > >  	mutex_lock(&text_mutex);
> > >  	/* Lock modules while optimizing kprobes */
> > > -	mutex_lock(&module_mutex);
> > > +	lock_modules();
> > >  
> > >  	/*
> > >  	 * Step 1: Unoptimize kprobes and collect cleaned (unused and disarmed)
> > > @@ -589,7 +589,7 @@ static void kprobe_optimizer(struct work_struct *work)
> > >  	/* Step 4: Free cleaned kprobes after quiesence period */
> > >  	do_free_cleaned_kprobes();
> > >  
> > > -	mutex_unlock(&module_mutex);
> > > +	unlock_modules();
> > >  	mutex_unlock(&text_mutex);
> > >  	cpus_read_unlock();
> > 
> > BTW., it would be nice to expand on the comments above - exactly which 
> > parts of the modules code is being serialized against and why?
> > 
> > We already hold the text_mutex here, which should protect against most 
> > kprobes related activities interfering - and it's unclear (to me) 
> > which part of the modules code is being serialized with here, and the 
> > 'lock modules while optimizing kprobes' comments is unhelpful. :-)
> > 
> > Thanks,
> > 
> > 	Ingo
> 
> AFAIK, only if you need to call find_module(), you ever need to acquire
> this mutex. 99% of time it is internally taken care by kernel/module.c.
> 
> I cannot make up any obvious reason to acquire it here.

If it's unnecessary, then it needs to be removed.

If it's necessary, then it needs to be documented better.

Thanks,

	Ingo
