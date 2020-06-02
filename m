Return-Path: <SRS0=QAx1=7P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDFF7C433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 19:34:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B8D28206E2
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 19:34:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MhJcTwo6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727860AbgFBTeD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jun 2020 15:34:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726809AbgFBTeC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jun 2020 15:34:02 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FCEEC08C5C0
        for <linux-kernel@vger.kernel.org>; Tue,  2 Jun 2020 12:34:02 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id x207so3741485pfc.5
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jun 2020 12:34:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rhbHp95kWOKsMTn2kJlI+6kFGDRXkED2LqzxYSlher4=;
        b=MhJcTwo6HwYbNgEc+ExSmsO0IlkIo33Me4OFsIko7H4p/davHsjvQxCaIzy2uipC/L
         g21jxZG9y+j6bT1t4kLB724vx+92V/V0ZqhEWjg8h9HWRFFA+0/dWiwdM93iT0pwFtu+
         GjlDPX/tc5iJEM9O5CzsheMcC9RsVnTfvm8ogdPF/7g6zox2rGUPot8TH+w4QOe9JJ1h
         IP8heVwfINOhnM4vy66T46rMPul0Q9aSoH1f6FbOtR6XtW66ucBx6Pc5HM2QKUBVvyNi
         yn4RCI3gBeOodqATLm/YXEf/yDpQ357CmWMldGUq5+h5uNI3hmHY1lYgYfXPaxE2UHNV
         bdag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rhbHp95kWOKsMTn2kJlI+6kFGDRXkED2LqzxYSlher4=;
        b=dU6R0WBQxWSPNlU9ucJSGtXr1sD/snXtU08cxadkBPjyMj9DnCUV8PKDLpQhpHQjSu
         JWetTKSg7E33f29RmUn0kJUs4Ffhb/1pVTMJNC63e1lez5s0hlKns14oMW9z7s7etHUg
         IAW4t+pH2XO0uMEgmJNpIeZIY90PQTW1Ld8v3l74sbCYKI8sDVB3i16jGuDfI67RlU0V
         Hp7TtZ+4UVJ6QKnpiGwfdvlUcSyEh8ODlvREPmfmGRY8eCq0DehPQxg7iVuFgrRR/VT5
         LC+kyM0gJkGYl3mPQ2FGH2tN1nlCOQsnfoFzW03tO+E7Mw7ptf5DgNlYunvoABpAOMc0
         BwdA==
X-Gm-Message-State: AOAM533KttKiLV8KobkoezstkPTXYw3FBfIRocGsGsJPi9ZZiPoMPENR
        BS39WymKO4cvuopohrsoxQMWNSxRhWGNdMkJ7FRFXhCKPY0=
X-Google-Smtp-Source: ABdhPJzQFBBEXGlVKjw7y8H/AbAaadIBe0OvYKSn2tDk4MZhCitP4+Od3+GxdYCieJxU/fGoA9D8ydtazPOWH9RGC88=
X-Received: by 2002:a17:90a:df82:: with SMTP id p2mr766872pjv.217.1591126441371;
 Tue, 02 Jun 2020 12:34:01 -0700 (PDT)
MIME-Version: 1.0
References: <20200602054216.93122-1-davidgow@google.com>
In-Reply-To: <20200602054216.93122-1-davidgow@google.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Tue, 2 Jun 2020 12:33:49 -0700
Message-ID: <CAFd5g46cJPD5X=88dwwd4Y9v1o18MsJiX47qjkTVAN4DbEPrCA@mail.gmail.com>
Subject: Re: [PATCH] Documentation: kunit: Add some troubleshooting tips to
 the FAQ
To:     David Gow <davidgow@google.com>
Cc:     Alan Maguire <alan.maguire@oracle.com>,
        Jonathan Corbet <corbet@lwn.net>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 1, 2020 at 10:42 PM David Gow <davidgow@google.com> wrote:
>
> Add an FAQ entry to the KUnit documentation with some tips for
> troubleshooting KUnit and kunit_tool.
>
> These suggestions largely came from an email thread:
> https://lore.kernel.org/linux-kselftest/41db8bbd-3ba0-8bde-7352-083bf4b947ff@intel.com/T/#m23213d4e156db6d59b0b460a9014950f5ff6eb03
>
> Signed-off-by: David Gow <davidgow@google.com>

Looks good to me + Alan's suggestion.

Reviewed-by: Brendan Higgins <brendanhiggins@google.com>
