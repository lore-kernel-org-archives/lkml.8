Return-Path: <SRS0=wIUh=66=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13124C433E0
	for <linux-kernel@archiver.kernel.org>; Sat, 16 May 2020 12:03:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D8982207D8
	for <linux-kernel@archiver.kernel.org>; Sat, 16 May 2020 12:03:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="KBtfuI2u"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726270AbgEPMDC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 May 2020 08:03:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726202AbgEPMDB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 May 2020 08:03:01 -0400
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8086AC061A0C;
        Sat, 16 May 2020 05:03:01 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 49PP6p5Zrjz9sTC;
        Sat, 16 May 2020 22:02:58 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
        s=201909; t=1589630579;
        bh=QgYBois2mghF1Y10/LekamhGD3B4slcgmEuonrdPApg=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=KBtfuI2uJoQ37VAKAx4uEME1Y48JK6KtPHBypGwS7+4RTSxPDGdqLpW7I9cOrT81Q
         w4VuNh80ulQRAdzwzUcwlkEZPP83zIVwC4XZeASe/UHasi4N9X7IoT3dCZYEOn+R8+
         SUGXgD7qAHaW+7+hsfRoKgHLOfDmjKqIM5Jg1MMCPNT9er2R3r1NcbeTn34/q7oiW6
         8r0RxzqFrprbzfrjy/I8ZjXS96g9p4mIQ3pqE2pDzYNJLRR6JzmTAjON0vaR68tqt6
         ePHo2TFo7eEd8WDLOY2BikhK50X4DqIwF81jWLggAobfsQH7ha9NaVvVsksspXBdan
         VGi1eLRYhYrCQ==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     "Paul A. Clarke" <pc@us.ibm.com>
Cc:     linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        acme@kernel.org, ananth@linux.vnet.ibm.com,
        maddy@linux.vnet.ibm.com, naveen.n.rao@linux.vnet.ibm.com,
        sukadev@linux.ibm.com, irogers@google.com
Subject: Re: [PATCH 2/2] perf: Add missing metrics to POWER9 'cpi_breakdown'
In-Reply-To: <20200514210425.GA3338@oc3272150783.ibm.com>
References: <1588868938-21933-1-git-send-email-pc@us.ibm.com> <1588868938-21933-3-git-send-email-pc@us.ibm.com> <87eerob5n4.fsf@mpe.ellerman.id.au> <20200514210425.GA3338@oc3272150783.ibm.com>
Date:   Sat, 16 May 2020 22:03:19 +1000
Message-ID: <87sgg09jeg.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"Paul A. Clarke" <pc@us.ibm.com> writes:
> On Wed, May 13, 2020 at 06:28:31PM +1000, Michael Ellerman wrote:
>> "Paul A. Clarke" <pc@us.ibm.com> writes:
>> > Add the following metrics to the POWER9 'cpi_breakdown' metricgroup:
>> > - ict_noslot_br_mpred_cpi
>> > - ict_noslot_br_mpred_icmiss_cpi
>> > - ict_noslot_cyc_other_cpi
>> > - ict_noslot_disp_held_cpi
>> > - ict_noslot_disp_held_hb_full_cpi
>> > - ict_noslot_disp_held_issq_cpi
>> > - ict_noslot_disp_held_other_cpi
>> > - ict_noslot_disp_held_sync_cpi
>> > - ict_noslot_disp_held_tbegin_cpi
>> > - ict_noslot_ic_l2_cpi
>> > - ict_noslot_ic_l3_cpi
>> > - ict_noslot_ic_l3miss_cpi
>> > - ict_noslot_ic_miss_cpi
>> >
>> > Signed-off-by: Paul A. Clarke <pc@us.ibm.com>
>> > ---
>> >  .../arch/powerpc/power9/metrics.json          | 143 ++++++++++--------
>> >  1 file changed, 78 insertions(+), 65 deletions(-)
>> >
>> > diff --git a/tools/perf/pmu-events/arch/powerpc/power9/metrics.json b/tools/perf/pmu-events/arch/powerpc/power9/metrics.json
>> > index 811c2a8c1c9e..6169351a72c8 100644
>> > --- a/tools/perf/pmu-events/arch/powerpc/power9/metrics.json
>> > +++ b/tools/perf/pmu-events/arch/powerpc/power9/metrics.json
>> > @@ -207,6 +207,84 @@
>> >          "MetricGroup": "cpi_breakdown",
>> >          "MetricName": "fxu_stall_cpi"
>> >      },
>> > +    {
>> > +        "BriefDescription": "Ict empty for this thread due to branch mispred",
>> 
>> I think you're just moving this, not adding it. But ICT is an acronym,
>> so it should be spelled ICT not Ict.
>> 
>> It might be worth expanding it too?
>
> This was 98% produced through automated means, translating an existing
> XML file to perf's JSON format.
>
> I've gotten the upstream XML file changed to include the "ICT" metrics
> in the "cpi_breakdown" group already, and can request the changes you
> suggest also be incorporated.
>
> For the time being, can we move forward with the patch as-is?

Fine by me.

cheers
