Return-Path: <SRS0=ro3C=3X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A7EBC35247
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 22:27:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3BE3720721
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 22:27:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Iy1TKpsh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727105AbgBCW0h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Feb 2020 17:26:37 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:32293 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726992AbgBCW0g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Feb 2020 17:26:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1580768795;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=PKlVXWvAtzBh0O+OSdcgLrbxm6cHx3rHTWHUYIxhjyE=;
        b=Iy1TKpshtOHM1ROu2ZBhB8Gr58/JdB2IFY/oz0ck3aHf4obBPEIdTkhkDBLYlySVoOKz4b
        hirNTzB01TnIGRwZIf88i5/0AFpodXNRswrs+iq/yroC4rhZUKqB/b9VRoscTeUl0D7LEr
        GhVryPd4y/SCCW9BULcOUAF92dft1Rw=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-208-DmX3tXOuMsG6TbV9ELyz5w-1; Mon, 03 Feb 2020 17:26:33 -0500
X-MC-Unique: DmX3tXOuMsG6TbV9ELyz5w-1
Received: by mail-pj1-f72.google.com with SMTP id 14so573052pjo.3
        for <linux-kernel@vger.kernel.org>; Mon, 03 Feb 2020 14:26:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=PKlVXWvAtzBh0O+OSdcgLrbxm6cHx3rHTWHUYIxhjyE=;
        b=AODYHeb2ewqBI2DFmKbl1tj2NWpxrBslGN7V7ChhgkG4coVlVR2e9GB/YcgCae7A2U
         laJ/Cqmwau+3YHPgOahTkKYt+aJsL1aVPnPEO5gAIgFHRn+3s3REGK9AyHLcemSDNOtv
         3fW/BsFFV+hDQ3Z1mNqGR+5yOqfmkXjsF7k4EzgW+xWErwy01LrKOSkggkCWfP6+o78c
         QqF7OGzoJEJ1y0Ju6qcaxS6RaGV0bPZkR8AXKLBUUCiG8LFmzG/4dmNglHg5fSkgIfEe
         7lFPmRdRXjq6e0PLjNQaRJl1kFQa+AYnsHXvkK9BizsShNGQ7EyFNQEgueUbmJUoitjA
         K5bg==
X-Gm-Message-State: APjAAAVLnwfgg1wLiLn+xDAHFz2yz50wDTRPRl9GQOJ7Z4J9nfO3TK3J
        5qbXWdyXGqYXJzSTtn4j0dgwcJEwuc511FI6aiqmcHTK1cbifNXlfFgjVYt8oanAyPIdAF6Ubee
        KeV6GK12X62YBJ2lgMDQPvGAm
X-Received: by 2002:a63:6607:: with SMTP id a7mr3246868pgc.310.1580768792787;
        Mon, 03 Feb 2020 14:26:32 -0800 (PST)
X-Google-Smtp-Source: APXvYqyLQjUhinPxT4gqFJCuEvTOo0KmNsperkBusji/i/cCiipn9md1/jw11bm4ZjlvtUiTM27tVA==
X-Received: by 2002:a63:6607:: with SMTP id a7mr3246847pgc.310.1580768792486;
        Mon, 03 Feb 2020 14:26:32 -0800 (PST)
Received: from localhost ([122.177.227.116])
        by smtp.gmail.com with ESMTPSA id c1sm21606857pfa.51.2020.02.03.14.26.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Feb 2020 14:26:32 -0800 (PST)
From:   Bhupesh Sharma <bhsharma@redhat.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, bhsharma@redhat.com,
        bhupesh.linux@gmail.com, Mark Rutland <mark.rutland@arm.com>,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>
Subject: [PATCH 0/2] Fix some arm64 perf issues
Date:   Tue,  4 Feb 2020 03:56:22 +0530
Message-Id: <1580768784-25868-1-git-send-email-bhsharma@redhat.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset tries to address some arm64 perf issues.

While the 1st patch is a generic one and just removes a dead/left-over
declaration:
[PATCH 1/2]: hw_breakpoint: Remove unused '__register_perf_hw_breakpoint' declaration

the 2nd patch addresses 'perf stat -e' like use-cases on arm64 which
allow per-task address execution h/w breakpoints:
[PATCH 2/2]: perf/arm64: Allow per-task kernel breakpoints

Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>

Bhupesh Sharma (2):
  hw_breakpoint: Remove unused '__register_perf_hw_breakpoint'
    declaration
  perf/arm64: Allow per-task kernel breakpoints

 arch/arm64/kernel/hw_breakpoint.c | 7 -------
 include/linux/hw_breakpoint.h     | 3 ---
 2 files changed, 10 deletions(-)

-- 
2.7.4

