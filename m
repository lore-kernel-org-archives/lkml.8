Return-Path: <SRS0=iZC5=5S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6C7FC43331
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 00:49:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C3AF2072E
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 00:49:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PcGSehvH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733186AbgDBAtu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Apr 2020 20:49:50 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:51841 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1732527AbgDBAtt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Apr 2020 20:49:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1585788587;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=oaYN663S39LRal92aerl+pCQNdZHmrsAe/MOf7r11ag=;
        b=PcGSehvHqhWM7Q+jvX2D16Is6r79pO52SCnBK1nSkJXeeyAOUM9FG9yIxLL1lGvcOO57kG
        cLYIrpOLwDHQaNnc3i9kbIbRYTbIqoHAvke8hIAbtvbFMDI1aRqEksVqWdB+3PDMPZdEQ6
        vaI3DtF7pTqfIGz8wDeD2dtdvLJFAHY=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-404-sWOJUljpNcSz58UXO1F7nA-1; Wed, 01 Apr 2020 20:49:46 -0400
X-MC-Unique: sWOJUljpNcSz58UXO1F7nA-1
Received: by mail-qv1-f70.google.com with SMTP id m11so1259266qvf.20
        for <linux-kernel@vger.kernel.org>; Wed, 01 Apr 2020 17:49:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=oaYN663S39LRal92aerl+pCQNdZHmrsAe/MOf7r11ag=;
        b=YAMu2wnIY+PPb8XKw3IliOgc+HJOdN/PowwOL5uOpr3DyIdgv5O4z0PftkLsNaFuZE
         qJEn1k4//RHlbxhKllFoq1PqeWsO34ylR/aRGPSpiYfdIy209TRkaQ9R659v0wW8NatP
         b6SYsGWKh9cTPD75xz4xU74m8r5+YeSuhxPWYtOcCeS+m03RX/JO3gCLu+djh64zCVYp
         Zi96KFs53xzgssV63LXJyp93QcSf7PwBpTI21OUgxD0KzRtO/Jf7QMZe9aohwRbzB2YY
         wV6JqymSgTkFLA4KsYLtYjFAqoiqTB+X6o4sjo6gMUpq4sOJabUZzdVOUkI2eitx/6Ed
         9RDQ==
X-Gm-Message-State: AGi0PuYy/fx7+xF9ISjmxK/gQLaANlsERybP3m8JGatUxVa4apNkbad7
        LN23Obl2HCaPqdbruG6XHBG33Ez/MEEkhONPw1HCupPHPQfVeLNBB/s5duFu0mbXl8oJu4pPthl
        HyCbB3weHxRYv8DS+EjLtzn6F
X-Received: by 2002:a05:620a:109c:: with SMTP id g28mr1010775qkk.409.1585788585940;
        Wed, 01 Apr 2020 17:49:45 -0700 (PDT)
X-Google-Smtp-Source: APiQypImnyYICyTeoY3h+JHEiKGNzZo+uWVbJsS4EdM8IEne9sUZlptwesCcpv4AihvANY3HWVyzOg==
X-Received: by 2002:a05:620a:109c:: with SMTP id g28mr1010757qkk.409.1585788585646;
        Wed, 01 Apr 2020 17:49:45 -0700 (PDT)
Received: from xz-x1 ([2607:9880:19c0:32::2])
        by smtp.gmail.com with ESMTPSA id d128sm117307qkg.12.2020.04.01.17.49.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Apr 2020 17:49:44 -0700 (PDT)
Date:   Wed, 1 Apr 2020 20:50:03 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, Ming Lei <ming.lei@redhat.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Luiz Capitulino <lcapitulino@redhat.com>
Subject: Re: [PATCH] sched/isolation: Allow "isolcpus=" to skip unknown
 sub-parameters
Message-ID: <20200402005003.GF7174@xz-x1>
References: <20200204161639.267026-1-peterx@redhat.com>
 <87d08rosof.fsf@nanos.tec.linutronix.de>
 <20200401230105.GF648829@xz-x1>
 <87wo6yokdx.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87wo6yokdx.fsf@nanos.tec.linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 02, 2020 at 01:29:14AM +0200, Thomas Gleixner wrote:
> Peter Xu <peterx@redhat.com> writes:
> 
> > On Wed, Apr 01, 2020 at 10:30:08PM +0200, Thomas Gleixner wrote:
> >> Peter Xu <peterx@redhat.com> writes:
> >> > @@ -169,8 +169,12 @@ static int __init housekeeping_isolcpus_setup(char *str)
> >> >  			continue;
> >> >  		}
> >> >  
> >> > -		pr_warn("isolcpus: Error, unknown flag\n");
> >> > -		return 0;
> >> > +		str = strchr(str, ',');
> >> > +		if (str)
> >> > +			/* Skip unknown sub-parameter */
> >> > +			str++;
> >> > +		else
> >> > +			return 0;
> >> 
> >> Just looked at it again because I wanted to apply this and contrary to
> >> last time I figured out that this is broken:
> >> 
> >>      isolcpus=nohz,domain1,3,5
> >> 
> >> is a malformatted option, but the above will make it "valid" and result
> >> in:
> >> 
> >>      HK_FLAG_TICK and a cpumask of 3,5.
> >
> > I would think this is no worse than applying nothing - I read the
> > first "isalpha()" check as something like "the subparameter's first
> > character must not be a digit", so to differenciate with the cpu list.
> > If we keep this, we can still have subparams like "double-word".
> 
> It _is_ worse. If the intention is to write 'nohz,domain,1,3,5' and
> that missing comma morphs it silently into 'nohz,3,5' then this is
> really a step backwards. The upstream version would tell you that you
> screwed up.
> 
> >>  static int __init housekeeping_isolcpus_setup(char *str)
> >>  {
> >>  	unsigned int flags = 0;
> >> +	char *par;
> >> +	int len;
> >>  
> >>  	while (isalpha(*str)) {
> >>  		if (!strncmp(str, "nohz,", 5)) {
> >> @@ -169,8 +171,17 @@ static int __init housekeeping_isolcpus_
> >>  			continue;
> >>  		}
> >>  
> >> -		pr_warn("isolcpus: Error, unknown flag\n");
> >> -		return 0;
> >> +		/*
> >> +		 * Skip unknown sub-parameter and validate that it is not
> >> +		 * containing an invalid character.
> >> +		 */
> >> +		for (par = str, len = 0; isalpha(*str); str++, len++);
> >> +		if (*str != ',') {
> >> +			pr_warn("isolcpus: Invalid flag %*s\n", len, par);
> >
> > ... this will dump "isolcpus: Invalid flag domain1,3,5", is this what
> > we wanted?  Maybe only dumps "domain1"?
> 
> No, it will dump: "domain1" at least if my understanding of is_alpha()
> and the '%*s' format option is halfways correct

It will dump "isolcpus: Invalid flag domain1,3,5". Do you mean "%.*s"
instead?

Another issue is even if to use "%.*s" it'll only dump "domain".  How
about something like (declare "illegal" as bool):

		/*
		 * Skip unknown sub-parameter and validate that it is not
		 * containing an invalid character.
		 */
		for (par = str, len = 0; *str && *str != ','; str++, len++)
			if (!isalpha(*str))
				illegal = true;

		if (illegal) {
			pr_warn("isolcpus: Invalid flag %.*s\n", len, par);
			return 0;
		}

		pr_info("isolcpus: Skipped unknown flag %.*s\n", len, par);
		str++;

> 
> > For me so far I would still prefer the original one, giving more
> > freedom to the future params and the patch is also a bit easier (but I
> 
> Again. It does not matter whether the patch is easier or not. What
> matters is correctness and usability. Silently converting a typo into
> something else is horrible at best.

Frankly speaking I really see it as simple as "we define a rule to
write these parameters, and people follow"...  But I won't argue more.

If you see above clip looks good, I can repost with a formal patch.

Thanks,

> 
> > definitely like the pr_warn when there's unknown subparams).  But just
> > let me know your preference and I'll follow yours when repost.
> 
> Enforcing a pure 'is_alpha()' subparam space is not really a substantial
> restriction. Feel free to extend it by adding '|| *str == '_' if you
> really think that provides a value. 
> 
> Thanks,
> 
>         tglx
> 

-- 
Peter Xu

