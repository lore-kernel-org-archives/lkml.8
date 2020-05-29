Return-Path: <SRS0=LUA0=7L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8EE9C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 15:56:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B007F2100A
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 15:56:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590767760;
	bh=m+jcsykm+TW2y0bo/N/rJxtCYIdbNcmPcUFeFsZe18o=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=0ow+iKpcnFXSN3OzYnqVOz0aHove9o41wfV8Sf2AfaTZLvOu1eIgvd9N1kr9yuLt6
	 F1Cr6bDSauRgIKzG4Co7wAhSML6dfuadALDlpuatohnUWTAjS7S9aa9fxEogHT3qe8
	 ebDdN6ZsJ0m9Sv9NcbvVCrT6Vs2UAQ4nW/F6kDOM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727774AbgE2P4A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 May 2020 11:56:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:34278 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727025AbgE2Pz7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 May 2020 11:55:59 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.37.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 492F22072D;
        Fri, 29 May 2020 15:55:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590767759;
        bh=m+jcsykm+TW2y0bo/N/rJxtCYIdbNcmPcUFeFsZe18o=;
        h=From:To:Cc:Subject:Date:From;
        b=KTlDX/OamOCMpbTwBD9FPF70s0/KCj90bHul8GsplY+sE/9PXvOBE6Ts7hGZV7JeC
         WLvoSbma2OcnLk1wEL/ggCZlkKaBd/20i68Afwh90JGyUcuPqiIxqLIwfPHcBZDXUz
         V12R+HbqMFYVCeKpu9FeiMKJc5uuv1fosaGh7FuI=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [RFC 0/2] tools/build/ patches to allow setting NO_SYSCALL_TABLE=1 from make command line
Date:   Fri, 29 May 2020 12:55:50 -0300
Message-Id: <20200529155552.463-1-acme@kernel.org>
X-Mailer: git-send-email 2.21.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

Hi Jiri,

	Can you please take a look if these are ok? I've tested it
extensively, but being Makefiles, I may be missing something... There
are more patches on top of these in the tmp.perf/core branch in my tree,
if you could take a quick look on those, that would be great as well.
The one that makes libaudit not be tested by default, for instace.

Best regards,

- Arnaldo

Arnaldo Carvalho de Melo (2):
  perf build: Group the NO_SYSCALL_TABLE logic
  perf build: Allow explicitely disabling the NO_SYSCALL_TABLE variable

 tools/perf/Makefile.config | 27 ++++++++++++++++++---------
 1 file changed, 18 insertions(+), 9 deletions(-)

-- 
2.25.3

