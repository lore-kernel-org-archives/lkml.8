Return-Path: <SRS0=rw9U=6H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF4DEC54FCB
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 11:21:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A7AB920728
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 11:21:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="qpZpn418"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728049AbgDWLVy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Apr 2020 07:21:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727906AbgDWLVy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Apr 2020 07:21:54 -0400
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACF16C035494
        for <linux-kernel@vger.kernel.org>; Thu, 23 Apr 2020 04:21:52 -0700 (PDT)
Received: by mail-qk1-x72c.google.com with SMTP id 20so5905951qkl.10
        for <linux-kernel@vger.kernel.org>; Thu, 23 Apr 2020 04:21:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=content-transfer-encoding:from:mime-version:subject:date:message-id
         :references:cc:in-reply-to:to;
        bh=lhSh3eeIrke7xfXKnLFNXKOf7zLgRTGB4zBEZI1sk9g=;
        b=qpZpn418fjli1sjLRSCDf4Z9TslZc9yxlHp58Ar+UoSa/Q90/ZktKFklxfqgiaZcXC
         +0QjcIdo14gMn+xGuMTN4ToxeQBFlK7EHlX/S7JUu1yqdze9VpUYM/zp1zfypc8ZrXBo
         dLq5yeRrT36EXtSPD8fDPQxviDTbyOoSlWG7BvC7HnYK+aSgaQVDXH8sXUOMjCfI2C5r
         mUXK9jqRMjn2pLOffDqZfXxV5QmHcyCThLlCWuaTLLs8jxSStdyI6nI9wsmpBPXRNwn3
         JCbbpfoBPiVvq/IE/w/w7IIcWdybfrAr6fnB6yYJqkmnOm2fN0CjszfXdXXQiPM/CXrk
         IRXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=lhSh3eeIrke7xfXKnLFNXKOf7zLgRTGB4zBEZI1sk9g=;
        b=TKNYCokHR3H/CLjW48c+k0NCSaTlRYr8HYAOfmqReN5QEqsizt0NsT7A7uDgaGWZuq
         ObsqKbm2j0LGypdVbwS+Ytc5w8/gjMtcVU6X+mC9zN5w/AiH1JFfqSF03AAk4eGBV+FY
         Gz27YQPXfo/tmyFBEMr+rfn0wz8AYX/NHoRx5qj1+De55DvMaw4VLSdOjnstq8ITT3Bo
         DERXcjvyfFqyqULXrdfcJoN2YgV0zSRxqJZ3wKOWNP4J5MnhtRVrys+HwSdM3IykHBz5
         BbxruOAFNhkEglMkZ0Njey+6+bon8iAQkqrfea+/LTRd3FluWcKbZQUFHNCd23+vFajT
         WOFA==
X-Gm-Message-State: AGi0PubsgTe5sCGlQYg2+i951JdSe/fRH7vxNzProhzl89wgK3t3Ss6C
        ft0TVPcYEeZ8vhbpye6FvUxAEA==
X-Google-Smtp-Source: APiQypLDqOeq0j4hdrOybglF5MTms1JyE7yH8wR1Y18AG5O0Jhl9zHIBIZR/cIcoPBpfH9yTZzOMVw==
X-Received: by 2002:ae9:dfc5:: with SMTP id t188mr2741170qkf.384.1587640911889;
        Thu, 23 Apr 2020 04:21:51 -0700 (PDT)
Received: from [192.168.1.183] (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id n31sm1550523qtc.36.2020.04.23.04.21.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Apr 2020 04:21:51 -0700 (PDT)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
From:   Qian Cai <cai@lca.pw>
Mime-Version: 1.0 (1.0)
Subject: Re: AMD boot woe due to "x86/mm: Cleanup pgprot_4k_2_large() and pgprot_large_2_4k()"
Date:   Thu, 23 Apr 2020 07:21:50 -0400
Message-Id: <DD433C5F-2A08-4730-B039-8E0C25911D10@lca.pw>
References: <72CCEEC2-FF21-437C-873C-4C31640B2913@alien8.de>
Cc:     Christoph Hellwig <hch@lst.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        kasan-dev <kasan-dev@googlegroups.com>
In-Reply-To: <72CCEEC2-FF21-437C-873C-4C31640B2913@alien8.de>
To:     Boris Petkov <bp@alien8.de>
X-Mailer: iPhone Mail (17D50)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Apr 23, 2020, at 7:06 AM, Boris Petkov <bp@alien8.de> wrote:
>=20
> No need, I've rebased and testing. Stay tuned.

Cool. I can only advocate to take another closer look at this patchset (it l=
ooks like going to break PAE without the pgprotval_t fix), because bugs do c=
luster.=
