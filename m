Return-Path: <SRS0=dAmO=AZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70DDDC433E7
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 18:56:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 45EF422AAB
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 18:56:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594752982;
	bh=XBrveUxBJxO457EafyTfFwjDYerlhoSdCXvOusEMN2A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=N8D0dJZFhXbQ9yXk6ntMOTklSKRTb720j8q03TI7fGA9VEe+JippxTiekdXx4BC6D
	 MPmX0trw/UfbXBZlYjkftF313Rfw00AUFinXG8FZ/43kkcPPL6BfevCDhO/t86Bxjq
	 iVjqJ8YG//jhdvZDgfG/oiz7tBDO01GMny6NkcuI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730969AbgGNS4U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jul 2020 14:56:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:54188 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729229AbgGNS4S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 14:56:18 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 229A5223B0;
        Tue, 14 Jul 2020 18:56:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594752977;
        bh=XBrveUxBJxO457EafyTfFwjDYerlhoSdCXvOusEMN2A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uVRuYfCjuIZdupOibNPHfhmhGTuL6z/tJzLCLs0oJqGocwXPP12PY3gBjbMUt+a9l
         rnp3FJ60P4zz7PDNTAMLKTckILqkBRsz/yn8Mc4VWWr1kZtkz2+Ui/Ufyhgn06PnjD
         wTuhWz2s71OEAIRQpf3BmrHithiQgLgoRR8HqkeE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Luwei Kang <luwei.kang@intel.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.7 073/166] perf intel-pt: Fix recording PEBS-via-PT with registers
Date:   Tue, 14 Jul 2020 20:43:58 +0200
Message-Id: <20200714184119.352467441@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200714184115.844176932@linuxfoundation.org>
References: <20200714184115.844176932@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Adrian Hunter <adrian.hunter@intel.com>

[ Upstream commit 75bcb8776dc987538f267ba4ba05ca43fc2b1676 ]

When recording PEBS-via-PT, the kernel will not accept the intel_pt
event with register sampling e.g.

 # perf record --kcore -c 10000 -e '{intel_pt/branch=0/,branch-loads/aux-output/ppp}' -I -- ls -l
 Error:
 intel_pt/branch=0/: PMU Hardware doesn't support sampling/overflow-interrupts. Try 'perf stat'

Fix by suppressing register sampling on the intel_pt evsel.

Committer notes:

Adrian informed that this is only available from Tremont onwards, so on
older processors the error continues the same as before.

Fixes: 9e64cefe4335b ("perf intel-pt: Process options for PEBS event synthesis")
Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Luwei Kang <luwei.kang@intel.com>
Link: http://lore.kernel.org/lkml/20200630133935.11150-2-adrian.hunter@intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/perf/arch/x86/util/intel-pt.c | 1 +
 tools/perf/util/evsel.c             | 4 ++--
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/tools/perf/arch/x86/util/intel-pt.c b/tools/perf/arch/x86/util/intel-pt.c
index 1643aed8c4c8e..2a548fbdf2a2a 100644
--- a/tools/perf/arch/x86/util/intel-pt.c
+++ b/tools/perf/arch/x86/util/intel-pt.c
@@ -634,6 +634,7 @@ static int intel_pt_recording_options(struct auxtrace_record *itr,
 			}
 			evsel->core.attr.freq = 0;
 			evsel->core.attr.sample_period = 1;
+			evsel->no_aux_samples = true;
 			intel_pt_evsel = evsel;
 			opts->full_auxtrace = true;
 		}
diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index eb880efbce16d..386950f29792a 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -1048,12 +1048,12 @@ void perf_evsel__config(struct evsel *evsel, struct record_opts *opts,
 	if (callchain && callchain->enabled && !evsel->no_aux_samples)
 		perf_evsel__config_callchain(evsel, opts, callchain);
 
-	if (opts->sample_intr_regs) {
+	if (opts->sample_intr_regs && !evsel->no_aux_samples) {
 		attr->sample_regs_intr = opts->sample_intr_regs;
 		perf_evsel__set_sample_bit(evsel, REGS_INTR);
 	}
 
-	if (opts->sample_user_regs) {
+	if (opts->sample_user_regs && !evsel->no_aux_samples) {
 		attr->sample_regs_user |= opts->sample_user_regs;
 		perf_evsel__set_sample_bit(evsel, REGS_USER);
 	}
-- 
2.25.1



