Return-Path: <SRS0=EowN=3M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD686C32771
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jan 2020 02:15:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD89F24125
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jan 2020 02:15:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="QjKRZhIf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726234AbgAWCPK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jan 2020 21:15:10 -0500
Received: from mail-qv1-f47.google.com ([209.85.219.47]:44468 "EHLO
        mail-qv1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725911AbgAWCPK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jan 2020 21:15:10 -0500
Received: by mail-qv1-f47.google.com with SMTP id n8so767031qvg.11
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jan 2020 18:15:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=content-transfer-encoding:from:mime-version:subject:date:message-id
         :references:cc:in-reply-to:to;
        bh=FpLx9nFaQyFAkuAJUNg7if3TmeJOyQiHsoAjUEjz5tM=;
        b=QjKRZhIf2+pG9F7VVshAd2exE77r3GyVlGlemytZszkljoQ0RbUC6tFfNQPMyoHmjl
         9eIssjrm4eT3tR/JbG4R0pYhex6Xl7LOq0JXgi0e0UGgWmsRZNrAA8qezsTFG98XpReD
         nqrbnVZTs3hsKT8K3NhtP7BCPNKPdS9KFZOnejNo3t793bd+Mkygu67aBCnPJrEHng4q
         5M9Cpkjj2jn4WozkxiVr0RJDzkRVE748VLYv2o+O4o4MzVH+ILNSphvt2NFcXelGCTZn
         74fSa8v6/TCj0KKYO4DUOGE2ArXItV9KFWq1ok16pslpysw2OHa9FQVJ+aske6GMNyLa
         V0cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=FpLx9nFaQyFAkuAJUNg7if3TmeJOyQiHsoAjUEjz5tM=;
        b=ertcSG5mpBM3OgWv9PgfL3XrvEDuIlIDtoXz8JYyFQEMlBNbA8ndBYjeFZGCiGS1fI
         9Em42PydX71PDZpOLi99SSagGXo1oQ4pWhMXukFrCsIfD+3BJaovyEwr5eqpJugfDwAa
         H8Xbls2lJ+9kn7mXA56+8vHUyo7J2K1L7N7tdEMlsvPj1hljajbNznnn8Ae67knoacsF
         RFTIjRwoko+RCvCKY5xrf8cki7bJlpvJlISqTE8FSw5rx/7Ep7meWqC+0jGVRENCUK39
         7HKblCfzuYHYTAy4DRp/GoqKYgZx01eILo3gaGYuz94yMkwjJUbxEFreQsjdr6jZmqWw
         00WA==
X-Gm-Message-State: APjAAAVJDwnLipE1xdzbvy1SziEnigRHGKHkK16DTKKfE8HsXxOMV/ew
        jXHndn/WfSl2kv0FRmWPaz6Vuw==
X-Google-Smtp-Source: APXvYqwQMP1RJuPr6Nq60ESh0LcUalb8S9nIRyeKHjlqw/G5GeXoJXz0Ggq6YwSFYfVFSGFr4Wh+Jg==
X-Received: by 2002:ad4:496f:: with SMTP id p15mr13530960qvy.191.1579745709289;
        Wed, 22 Jan 2020 18:15:09 -0800 (PST)
Received: from [192.168.1.183] (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id z126sm250705qka.34.2020.01.22.18.15.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Jan 2020 18:15:08 -0800 (PST)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
From:   Qian Cai <cai@lca.pw>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH -next] x86/mm/pat: silence a data race in cpa_4k_install
Date:   Wed, 22 Jan 2020 21:15:07 -0500
Message-Id: <4F7E8467-98F0-483A-BF70-CD06AC78890D@lca.pw>
References: <20200122084604.GP14914@hirez.programming.kicks-ass.net>
Cc:     Borislav Petkov <bp@alien8.de>, Marco Elver <elver@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200122084604.GP14914@hirez.programming.kicks-ass.net>
To:     Peter Zijlstra <peterz@infradead.org>
X-Mailer: iPhone Mail (17C54)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Jan 22, 2020, at 3:46 AM, Peter Zijlstra <peterz@infradead.org> wrote:
>=20
> Documentation. It is a clear and concise marker of intent. Unintended
> data races are bad.
>=20
> Also, we've been adding annotations to the kernel source forever,
> sparse, lockdep, etc.. now KCSAN. All we have to do is make sure they're
> minimally invasive, and in that regard the date_race() marker is spot on
> IMO.

Okay, so which way should we move forward with this then? Borislav liked __n=
o_kasan_or_inline and Peter liked data_race(). I personally like data_race()=
 more because it has nothing to do with the GCC bug, but I realized my opini=
on has little weight here.=
