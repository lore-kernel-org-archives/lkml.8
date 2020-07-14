Return-Path: <SRS0=dAmO=AZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BDC6C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 20:41:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 48FCD2064B
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 20:41:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hYirHOdz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726789AbgGNUli (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jul 2020 16:41:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726492AbgGNUli (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 16:41:38 -0400
Received: from mail-qt1-x849.google.com (mail-qt1-x849.google.com [IPv6:2607:f8b0:4864:20::849])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3F3EC061755
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jul 2020 13:41:37 -0700 (PDT)
Received: by mail-qt1-x849.google.com with SMTP id h24so13425684qtk.18
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jul 2020 13:41:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=Q3rrVuP9UcmnEc3sFtdze+zW9FfErqo0k9Y3L17GKQE=;
        b=hYirHOdzI0sQFji9qH7roDn0LxGicKlGTxMz2qOWPolOluUbgars+R3ttiDM2N4DMH
         YOers1ca1QTctawzrEGsx9GDMOi0hYSQytUtBQyndWskw/iNZNombd6ldqho1wOu5vr5
         r/KbpGk1kthb4SfKnhtgRNWosVFE9GoLYxiZ63Q3QowMjKMRa5WpW8KpbDCKAnDluOpC
         9uDWcDFgIu+zmzs199k/Y2Kfykz6EFKNRsvWVmu3ChmRbjz7/fGaQq3ffwWuSk7itBqc
         vHVzLJYYb2quazJvK7I4AXOAtzD3pSMfT1gKur4haF60DwD35BZX6gG+rm/lucPztw2j
         Dzhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=Q3rrVuP9UcmnEc3sFtdze+zW9FfErqo0k9Y3L17GKQE=;
        b=mpHXNuHfOw29CEO92Z8x2rdg0q6ZcW8oMEDNJvS7RlL+TDCC003uAp7YXPjekgD1pK
         yin+pwIpi5rFW2q9ao/sXTm3lAz1+p2I8Rfxrc4JrNRdwYCicTt0uMBh401Pwk7ODiSQ
         CsrcJIZAE49Eh/eXihNRgYhWQ1TJdhMt9/OJsYhbAy4NsFgr8FV3vDwvoLhLZGR8MsB7
         u/MX7S5tkxIJonaq3fp35NwsHhWhjXEdFIUYDXXiFEN7tfjPRasyzQzTFcFBe+9NIC+k
         W9mDvZIV157dTsedg1Z54of7Y8+XrDOG61as59BDFWRSMULOKqBPqofn5xSF1VTyh6k6
         BF1w==
X-Gm-Message-State: AOAM533BSxBVyz+F4PNY0LM2Yfn13kkvrQv6B+KrWPj5lTcnGdjtPbkH
        OIw74x5CV19S0LPVVhFhJbJMgYOpdVZi2Gx/zc8lOQ==
X-Google-Smtp-Source: ABdhPJxjEriJNkfflDAtJ6oQdSMaIhOS/i3pb/+Nqu8CMMkXiwelLWUdnwm3+uOX+eRbCCDp7ZoW9QJPKNtEH3OoiCnoAg==
X-Received: by 2002:a0c:e008:: with SMTP id j8mr6522255qvk.87.1594759296996;
 Tue, 14 Jul 2020 13:41:36 -0700 (PDT)
Date:   Tue, 14 Jul 2020 13:41:28 -0700
Message-Id: <20200714204130.54729-1-brendanhiggins@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.27.0.389.gc38d7665816-goog
Subject: [PATCH v1 0/2] kunit: tool: fix kunit_tool unit tests
From:   Brendan Higgins <brendanhiggins@google.com>
To:     shuah@kernel.org, davidgow@google.com, vitor@massaru.org
Cc:     linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kernel@vger.kernel.org,
        Brendan Higgins <brendanhiggins@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Apparently we haven't run the unit tests for kunit_tool in a while and
consequently some things have broken. This patchset fixes those issues.

Brendan Higgins (2):
  kunit: tool: fix broken default args in unit tests
  kunit: tool: fix improper treatment of file location

 tools/testing/kunit/kunit.py           | 24 ------------------------
 tools/testing/kunit/kunit_tool_test.py | 14 +++++++-------
 2 files changed, 7 insertions(+), 31 deletions(-)


base-commit: a581387e415bbb0085e7e67906c8f4a99746590e
-- 
2.27.0.389.gc38d7665816-goog

