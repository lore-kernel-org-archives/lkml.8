Return-Path: <SRS0=za8s=32=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37C00C2D0B1
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 14:59:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B7CF227BF
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 14:59:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aL4a7PdQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727389AbgBFO70 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Feb 2020 09:59:26 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:33145 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725535AbgBFO7Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Feb 2020 09:59:25 -0500
Received: by mail-wr1-f66.google.com with SMTP id u6so7619389wrt.0
        for <linux-kernel@vger.kernel.org>; Thu, 06 Feb 2020 06:59:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=5p1GVFly9zarx/o5WAM5Fss4P5nkJ4MOlKp9Zzh5sJE=;
        b=aL4a7PdQBVIacqc7juAoGPXrOFDhqS0/WpUkzCEOj3gWHevkYGW4uCDSSe1b7TRbON
         uqGCaPlR7gL2FR8hN6WxLuy8EdIkgR0o2p2RJfPJlXUdbeQcGdwx/Yp0Bz3g9EbQY23Y
         +Wli5Oj9cK3h3K9cdiu4Du/CcmaoegUbZz8aRQQev3207ao/TQrCC1G4NvztfNOBSRYg
         R/zs7pv/i4iluhSgo1iIpeFysfm08vvZwGTowfVXjnEZe2fUYAyboCcm7wrWKEJklRWG
         id5fbHUIx2kpKGTwl/0gxn6ISayPJuPsWHlnfi4OjkosuvL/JyxvtFaReO9ejV4G3hw9
         ZkNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:in-reply-to:message-id
         :references:mime-version;
        bh=5p1GVFly9zarx/o5WAM5Fss4P5nkJ4MOlKp9Zzh5sJE=;
        b=TOEwasfXRJiWR8ybmByFQiGadk4B6WDv5a09S06yvzmGl+koPvpfON5DipmfjPLlKg
         tIaNCLhjjkLJPVgTODELiwMFCFZPPodeE/0pav6TpHt9RHVixk6qJIHWcycroWUnK29D
         XNEampldtg0OV3tcglL9zrvXWRK0NCU+tUb9hDpagY6/1pFqCtHImacIntnADGR9oF91
         TYGdeYzWLNdZq4lFM+o6ikUxRIrmPeUS5hL425AXZGVbuY+Vv4PjHoWxR1mytpVrm7vX
         7V5vSf/4GrjgP3XrT0jdmvCzZ409RbIDDdcKEuT8sNQMtMvy6eQ+6kbCDNHFNYosEP/Y
         V3Kw==
X-Gm-Message-State: APjAAAVaJ5pPY82mPjPIFpsq3DXZdnFVv55hH37ycsJc0rOA0JGRlvRa
        8UXPYnQVy9c6DMR3s1Pwfw==
X-Google-Smtp-Source: APXvYqxgiALTPV0pOTr2vUyS208Dzozrd/A0dhBaT3dsdtnnYjMrJCw37qv7aqxHrG+wgKkmeZFbyg==
X-Received: by 2002:a5d:4702:: with SMTP id y2mr4049567wrq.37.1581001163747;
        Thu, 06 Feb 2020 06:59:23 -0800 (PST)
Received: from ninjahub.lan (host-2-102-13-223.as13285.net. [2.102.13.223])
        by smtp.gmail.com with ESMTPSA id r1sm4427485wrx.11.2020.02.06.06.59.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Feb 2020 06:59:23 -0800 (PST)
From:   Jules Irenge <jbi.octave@gmail.com>
X-Google-Original-From: Jules Irenge <maxx@ninjahub.org>
Date:   Thu, 6 Feb 2020 14:59:15 +0000 (GMT)
To:     Peter Zijlstra <peterz@infradead.org>
cc:     Jules Irenge <jbi.octave@gmail.com>, boqun.feng@gmail.com,
        mingo@redhat.com, will@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kernel: locking: add releases(lock) annotation
In-Reply-To: <20191217091304.GY2844@hirez.programming.kicks-ass.net>
Message-ID: <alpine.LFD.2.21.2002061448070.63324@ninjahub.org>
References: <20191216153952.37038-1-jbi.octave@gmail.com> <20191217091304.GY2844@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 17 Dec 2019, Peter Zijlstra wrote:

> On Mon, Dec 16, 2019 at 03:39:52PM +0000, Jules Irenge wrote:
> > Add releases(lock) annotation to remove issue detected by sparse tool.
> > warning: context imbalance in xxxxxxx() - unexpected unlock
> > 
> > Signed-off-by: Jules Irenge <jbi.octave@gmail.com>
> 
> So, personally I detest these sparse things.
> 
> But I'm also confused, as that function already has the annotation, see
> spinlock_api_smp.h. In order for sparse to see these annotations at the
> usage size, they need to be on the declaration, not the definition.
> 

Yes, I completely agree with you, but acording to my short experience 
with Sparse, the warning at function definition will always be there 
despite the annotation being at the function declaration.

The annotation at declaration help fix the warning when the anotated 
function is called within another function, this function can be 
elsewhere. It fixes the warning at the function within which the 
annotated function has been called.

Please correct me if I am wrong.

Kind regards,
Jules
