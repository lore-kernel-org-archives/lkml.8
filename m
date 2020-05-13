Return-Path: <SRS0=g10L=63=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69CE1CA90AF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 08:28:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 44CD723129
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 08:28:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="XgKKjPCL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732244AbgEMI2T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 May 2020 04:28:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729189AbgEMI2T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 May 2020 04:28:19 -0400
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0187DC061A0C;
        Wed, 13 May 2020 01:28:19 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 49MSVS0BzMz9sRK;
        Wed, 13 May 2020 18:28:15 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
        s=201909; t=1589358496;
        bh=VP2grSwEfER1Bai7GqbXYBjVwa4ZbN5gCIzWfAq28gY=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=XgKKjPCLMtprSSSF53OUtTu15EnqWt3HRbKQbWybrQqq8A7tmMs4/3ksc913nJl6S
         WSnDF90nGGQZn500zCnbhXu6OhLvkyyRq9POWJwMgl2ogS14/KrT62RuuygwJ1Af4a
         l6WIhxYNy9Hs0/Y/gduCUDS8wzFvcRLmOh76M2/rIclUo/1qtOrwuvb+uA9cAEwcd9
         obddCOpTED75n+AKFkMl/4pusinTiChNG2Rn7O2aNNYkWru9nSgUZ1HOZchZdX94ot
         JY8mYhzDxpb4QQEkJmSDIrTBf8KqnQ+bP3jl9lCCizDhYA2FCySYflYIlVxSulj5nG
         oNSOgL+ItRtNw==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     "Paul A. Clarke" <pc@us.ibm.com>, linux-perf-users@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, acme@kernel.org,
        ananth@linux.vnet.ibm.com, maddy@linux.vnet.ibm.com,
        naveen.n.rao@linux.vnet.ibm.com, sukadev@linux.ibm.com,
        irogers@google.com
Subject: Re: [PATCH 2/2] perf: Add missing metrics to POWER9 'cpi_breakdown'
In-Reply-To: <1588868938-21933-3-git-send-email-pc@us.ibm.com>
References: <1588868938-21933-1-git-send-email-pc@us.ibm.com> <1588868938-21933-3-git-send-email-pc@us.ibm.com>
Date:   Wed, 13 May 2020 18:28:31 +1000
Message-ID: <87eerob5n4.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"Paul A. Clarke" <pc@us.ibm.com> writes:
> From: "Paul A. Clarke" <pc@us.ibm.com>
>
> Add the following metrics to the POWER9 'cpi_breakdown' metricgroup:
> - ict_noslot_br_mpred_cpi
> - ict_noslot_br_mpred_icmiss_cpi
> - ict_noslot_cyc_other_cpi
> - ict_noslot_disp_held_cpi
> - ict_noslot_disp_held_hb_full_cpi
> - ict_noslot_disp_held_issq_cpi
> - ict_noslot_disp_held_other_cpi
> - ict_noslot_disp_held_sync_cpi
> - ict_noslot_disp_held_tbegin_cpi
> - ict_noslot_ic_l2_cpi
> - ict_noslot_ic_l3_cpi
> - ict_noslot_ic_l3miss_cpi
> - ict_noslot_ic_miss_cpi
>
> Signed-off-by: Paul A. Clarke <pc@us.ibm.com>
> ---
>  .../arch/powerpc/power9/metrics.json          | 143 ++++++++++--------
>  1 file changed, 78 insertions(+), 65 deletions(-)
>
> diff --git a/tools/perf/pmu-events/arch/powerpc/power9/metrics.json b/tools/perf/pmu-events/arch/powerpc/power9/metrics.json
> index 811c2a8c1c9e..6169351a72c8 100644
> --- a/tools/perf/pmu-events/arch/powerpc/power9/metrics.json
> +++ b/tools/perf/pmu-events/arch/powerpc/power9/metrics.json
> @@ -207,6 +207,84 @@
>          "MetricGroup": "cpi_breakdown",
>          "MetricName": "fxu_stall_cpi"
>      },
> +    {
> +        "BriefDescription": "Ict empty for this thread due to branch mispred",

I think you're just moving this, not adding it. But ICT is an acronym,
so it should be spelled ICT not Ict.

It might be worth expanding it too?

cheers
