Return-Path: <SRS0=Ktsx=44=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E3D7C0044D
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 23:14:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5BA1B2074E
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 23:14:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="HfrBcWnO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731440AbgCKXON (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Mar 2020 19:14:13 -0400
Received: from mail-pf1-f172.google.com ([209.85.210.172]:44648 "EHLO
        mail-pf1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731338AbgCKXOM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 19:14:12 -0400
Received: by mail-pf1-f172.google.com with SMTP id b72so2200309pfb.11
        for <linux-kernel@vger.kernel.org>; Wed, 11 Mar 2020 16:14:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6fzqV9CIXY2BfnMARHLSgEpUszUvgGeFszKnXnVPv7A=;
        b=HfrBcWnOvQslSDkVIY+fV4VXSCSPc3FGdKCKUKZv11fcEjDmlkcTf8/HlVuJX/yQF0
         a9XpHbmV0UvsVi4zSHm0OBynQoVmqmE0KK82kPqlUg8/aODuMRaGcd5HEHAyDPYqh2OY
         L9QG0IiHzhCZngnxt1/5vAzlysvG1A7fNhknc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6fzqV9CIXY2BfnMARHLSgEpUszUvgGeFszKnXnVPv7A=;
        b=dfn8hWzRoEpwADYbFrgEBGjPL5h5gusOWqBlv7ot9lKua1++80jTGEbAkX85mJNlqs
         iqezwBnrI/nYcVZniS+DpAqnKkttOtq+D08T2Dw4tiHg6ailZI+8cP6F7AS1TY8d5Lov
         T5Nb1EwXQvjgN6WmJW8ueMtCubYCh8MGeoAZv78YTTQu2sYUM3jG68k5vU6hS7rUnf1U
         WL9JjugvO0CnZ0GKDuYk+zkBoqWgW+nKb8fyda6PQ6nZtFOgrL7a9si/JiiY68mWmIdV
         CzYjAOlOJkC4szPCIw63ygznsB4Ene5rF6W+y17V2HcsXot38aC2ZvdvsagBHytVZVo4
         rOhg==
X-Gm-Message-State: ANhLgQ2j42BSDakc8eZ0jbz72OkIpo0pO3/Ih45LchEirvbKbOlyYQrI
        5lnmWqW8QO7QqH3Pk1CKLyoD4w==
X-Google-Smtp-Source: ADFU+vtx6aR8psbf8LLqN1yirRS07sqKunMTmuIDgxuvkV+qlMK9XEO/i3wXp4RKuxjEwBLPylZHrQ==
X-Received: by 2002:a62:15cc:: with SMTP id 195mr3165847pfv.276.1583968451595;
        Wed, 11 Mar 2020 16:14:11 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:1:24fa:e766:52c9:e3b2])
        by smtp.gmail.com with ESMTPSA id g75sm2606334pje.37.2020.03.11.16.14.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Mar 2020 16:14:11 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Maulik Shah <mkshah@codeaurora.org>
Cc:     mka@chromium.org, Rajendra Nayak <rnayak@codeaurora.org>,
        evgreen@chromium.org, Lina Iyer <ilina@codeaurora.org>,
        swboyd@chromium.org, Douglas Anderson <dianders@chromium.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFT PATCH v2 00/10] drivers: qcom: rpmh-rsc: Cleanup / add lots of comments
Date:   Wed, 11 Mar 2020 16:13:38 -0700
Message-Id: <20200311231348.129254-1-dianders@chromium.org>
X-Mailer: git-send-email 2.25.1.481.gfbce0eb801-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to review Maulik's latest "rpmh_flush for non OSI targets"
patch series I've found myself trying to understand rpmh-rsc better.
To make it easier for others to do this in the future, add a whole lot
of comments / documentation.

As part of this there are a very small number of functional changes.
- We'll get a tiny performance boost by getting rid of the "cmd_cache"
  which I believe was unnecessary (though just to be sure, best to try
  this atop Maulik's patches where it should be super obvious that we
  always invalidate before writing sleep/wake TCSs.
- I think I've eliminated a possible deadlock on "nosmp" systems,
  though it was mostly theoretical.
- Possibly we could get a warning in some cases if I misunderstood how
  tcs_is_free() works.  It'd be easy to remove the warning, though.

These changes touch a lot of code in rpmh-rsc, so hopefully someone at
Qualcomm can test them out better than I did (I don't have every last
client of RPMH in my tree) and review them soon-ish so they can land
and future patches can be based on them.

I've tried to structure the patches so that simpler / less
controversial patches are first.  Those could certainly land on their
own without later patches.  Many of the patches could also be dropped
and the others would still apply if they are controversial.  If you
need help doing this then please yell.

At the end of this patch series there is still one TODO left in the
code.  Specifically I think we still have some problems when we try to
borrow a wakeup TCS for an active-only transfer.  The problems I think
are there aren't new, just the comment.  It's unclear if we should
land with the TODO in place or wait till that gets resolved first.

With all that, enjoy.

Changes in v2:
- Now prose in comments instead of struct definitions.
- Pretty ASCII art from Stephen.
- More clear that active-only xfers can happen on wake TCS sometimes.
- Document locks for updating "tcs_in_use" more.
- Document tcs_is_free() without drv->lock OK for tcs_invalidate().
- Document bug of tcs_write() not handling -EAGAIN.
- Document get_tcs_for_msg() => -EAGAIN only for ACTIVE_ONLY.
- Reword tcs_write() doc a bit.
- Document two get_tcs_for_msg() issues if zero-active TCS.
- Document that rpmh_rsc_send_data() can be an implicit invalidate.
- Fixed documentation of "tcs" param in find_slots().
- Comment tcs_is_free() new for v2; replaces old patch 6.
- Got rid of useless "if (x) continue" at end of for loop.
- ("Always use -EAGAIN, never -EBUSY") new for v2.

Douglas Anderson (10):
  drivers: qcom: rpmh-rsc: Clean code reading/writing regs/cmds
  drivers: qcom: rpmh-rsc: Document the register layout better
  drivers: qcom: rpmh-rsc: Fold tcs_ctrl_write() into its single caller
  drivers: qcom: rpmh-rsc: Remove get_tcs_of_type() abstraction
  drivers: qcom: rpmh-rsc: A lot of comments
  drivers: qcom: rpmh-rsc: Comment tcs_is_free() + warn if state
    mismatch
  drivers: qcom: rpmh-rsc: Warning if tcs_write() used for non-active
  drivers: qcom: rpmh-rsc: spin_lock_irqsave() for tcs_invalidate()
  drivers: qcom: rpmh-rsc: Kill cmd_cache and find_match() with fire
  drivers: qcom: rpmh-rsc: Always use -EAGAIN, never -EBUSY

 drivers/soc/qcom/rpmh-internal.h |  52 ++--
 drivers/soc/qcom/rpmh-rsc.c      | 443 +++++++++++++++++++++++--------
 2 files changed, 358 insertions(+), 137 deletions(-)

-- 
2.25.1.481.gfbce0eb801-goog

