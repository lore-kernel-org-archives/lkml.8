Return-Path: <SRS0=TDCE=AW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D44D7C433DF
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jul 2020 00:17:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ADB6E2075D
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jul 2020 00:17:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="bWOCH6Cn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726736AbgGKAR2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jul 2020 20:17:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726588AbgGKAR2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jul 2020 20:17:28 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE0E8C08C5DC
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jul 2020 17:17:27 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id rk21so7845112ejb.2
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jul 2020 17:17:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=07UDV8c7s43AMminACD/vOeIjMiQl5BAJR/a2NrKRyw=;
        b=bWOCH6CnHTtlGBHUfaiNHWGtPjzQW4lKRQoEbr1kdwnZmxUEYi+ZDFh4RvFMZhFw7s
         B29MXkLOfmi4HrCFxdDJ60ZOIjVzTG2WKEUSNhu86s8Eu3vf9R4ym4zDfViyto7Mw820
         seLCk3YE4C/5Vzw2ozeIZYf7AlUEolLcXpDl12PPzpD+LQO1NThwNlp4YQy8gX8SyKsS
         4hEE2TRw4uCV6PVpZFVdYsOMVL12gELQVntawAC4CZUOrrK9p6uJY+D5z9ZFhQCyXpPu
         5dZmE++EJ0EGjbmeEnpk0HERwKr/gDhG2lq7PhJWyn/GCJwTmW6wl0makWfmOKzvH8Ei
         dFZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=07UDV8c7s43AMminACD/vOeIjMiQl5BAJR/a2NrKRyw=;
        b=sbDCvPGdA41cuDgHCVQZFthJYF1squCy1qX2Juu0x/YODLtMqtqJilAyD+LXnXe8Z+
         KR8mS/fxFZZ9ARleAD85uhJo7oSQp1iTXydk4ChOd4tNs7wJGn8pyO6EI5cX9tKgTznO
         CSG9pDSQpiZ8YQj5TNQU8NOmrqa2zSMSmEU6uSSDcqzPBJ3QI5K4JgwYx69w9h2i3+De
         SocGDDTzpeqS3bqdehod+kz7Vomi75qaqMaNjCb96fIRJU9I2w7Z9N+atbysg4iUEhcV
         yMkMR2AbnJC5/PDMBRCjUdIuVqK3869vdcRYVkpzSa1FBVgC3r9eQ8ch6Gyv8MVAVH9t
         MSwg==
X-Gm-Message-State: AOAM531+pcA1Yoq8Hhea1aksiqXT0HCo6ksEsB2DYwYuu5juN/TIW5Zw
        vaU8DDxfqCbi9rx21s68FuuCIlVerITdvWaYzW9vw0knQHY=
X-Google-Smtp-Source: ABdhPJyWrBIjbvwC4SVnXw4MH+61NlPHBe1qvh7Jwe1zhtqL4eiYOqsb4Av0D+1n2YqjaaT8tpYlMNDz9GkrbWT7DfU=
X-Received: by 2002:a17:906:1a54:: with SMTP id j20mr62536609ejf.455.1594426646466;
 Fri, 10 Jul 2020 17:17:26 -0700 (PDT)
MIME-Version: 1.0
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Fri, 10 Jul 2020 17:17:15 -0700
Message-ID: <CAPcyv4gui-sbHHq8k9MmEojkSHd5XSF3RLBhUkM=sO8TKPAdZw@mail.gmail.com>
Subject: [GIT PULL] CodingStyle: Inclusive Terminology
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Greg KH <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus, please pull from:

  git://git.kernel.org/pub/scm/linux/kernel/git/djbw/linux
tags/inclusive-terminology

...to receive a coding-style update for v5.9. The discussion has
tapered off as well as the incoming ack, review, and sign-off tags. I
did not see a reason to wait for the next merge window.

Thank you.

---

The following changes since commit 9ebcfadb0610322ac537dd7aa5d9cbc2b2894c68:

  Linux 5.8-rc3 (2020-06-28 15:00:24 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/djbw/linux
tags/inclusive-terminology

for you to fetch changes up to a5f526ecb075a08c4a082355020166c7fe13ae27:

  CodingStyle: Inclusive Terminology (2020-07-03 23:54:35 -0700)

----------------------------------------------------------------
Extend coding-style with inclusive-terminology recommendations.

----------------------------------------------------------------
Dan Williams (1):
      CodingStyle: Inclusive Terminology

 Documentation/process/coding-style.rst | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

---

Acked-by: Randy Dunlap <rdunlap@infradead.org>
Acked-by: Dave Airlie <airlied@redhat.com>
Acked-by: SeongJae Park <sjpark@amazon.de>
Acked-by: Christian Brauner <christian.brauner@ubuntu.com>
Acked-by: James Bottomley <James.Bottomley@HansenPartnership.com>
Acked-by: Daniel Vetter <daniel.vetter@ffwll.ch>
Acked-by: Andy Lutomirski <luto@kernel.org>
Acked-by: Laura Abbott <laura@labbott.name>
Acked-by: Gustavo A. R. Silva <gustavoars@kernel.org>
Reviewed-by: Matthias Brugger <matthias.bgg@gmail.com>
Reviewed-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Olof Johansson <olof@lixom.net>
Signed-off-by: Jonathan Corbet <corbet@lwn.net>
Signed-off-by: Chris Mason <clm@fb.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
