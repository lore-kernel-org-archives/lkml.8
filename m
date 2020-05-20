Return-Path: <SRS0=sqqi=7C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0DC1C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 16:08:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8E115206F1
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 16:08:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xbrxSUuT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726946AbgETQIv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 May 2020 12:08:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726650AbgETQIv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 May 2020 12:08:51 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F22CEC061A0E
        for <linux-kernel@vger.kernel.org>; Wed, 20 May 2020 09:08:50 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id j5so3761572wrq.2
        for <linux-kernel@vger.kernel.org>; Wed, 20 May 2020 09:08:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=b0xYWh+w/F4qTSH0QTclL7MS2e+5mKVzQgF0NwX1VdA=;
        b=xbrxSUuTV4VsNXGHpyNiBREQh4CjaWtB9BN3dY9RtRsbQ3q6Wc1c9zuirNc4ZD5/nT
         Na+uOjpDr1J/5SJkZVH7w3a/7jxWGFfeFYXRkQlbsJuSC+swTEBM7Mihk9eJ9vk8eE1F
         rmg5VkyVcsfs5z09UB0WfHUjghVCddAtVvIF73rqjLcOJB0vkmJ/hNqUIM5K9bHYtYB2
         Qk4fB9WSOL3xDfNiYR6N7lAnv/yv1Jpgq+z/7mRt5cEmMc9CjeaaX+kHeO8sPiXuI/BX
         XKbg13F2pI5vgTw1ZgCCUDSxyFh3ptYp3UEMYTYaVhykHgrjuTAfikxoac2kbplmLjth
         OYDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=b0xYWh+w/F4qTSH0QTclL7MS2e+5mKVzQgF0NwX1VdA=;
        b=Kdc8jqbsv0+yqtN5UaPWHIxXb53lFuoIHQfZrAahf7tEVNy4VLnE46B3OVvCSkdNfj
         HGscsKdo9Y7kb+OJce65NjwG4JKnkiI53bVyCGwA2OnpArRnyvooRrvtXGxyzeyXHOsU
         CZOdmSO1pjzultxOu2vRI/oq0LVzJyhzIlYcK5gbcbQ3T2rfq1jzsKLPLZgUTKQYDnc/
         zQ1bie+ehwswf+QFVZajb0bPnnfyf1c64dOvEDhk22U00M8GnyHnFNYwLlYi6yxPVCeQ
         OuyIfyYMCSvkufbEMdkNfQDyYubbCowdT1BcQst5iP55/rfCIuXoLsTZUybYAPmLGI2E
         6Ctw==
X-Gm-Message-State: AOAM533QhFGDo+cBUoj5Ts82InEeoIa7Z7E01LWb4sKMaecYLweJgri6
        o6CGIs2SaZctl4mqzToYv4hQzQ==
X-Google-Smtp-Source: ABdhPJz93P3tc5SPc/AYro69bXA2d3D8ewi0B2Ij2Ds+zzrwsQ5omOgXlzrtQVfEBTM0udRUP66uEQ==
X-Received: by 2002:a5d:5751:: with SMTP id q17mr4842701wrw.106.1589990929733;
        Wed, 20 May 2020 09:08:49 -0700 (PDT)
Received: from holly.lan (cpc141214-aztw34-2-0-cust773.18-1.cable.virginm.net. [86.9.19.6])
        by smtp.gmail.com with ESMTPSA id z11sm3297731wro.48.2020.05.20.09.08.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2020 09:08:49 -0700 (PDT)
Date:   Wed, 20 May 2020 17:08:47 +0100
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Douglas Anderson <dianders@chromium.org>
Cc:     Jason Wessel <jason.wessel@windriver.com>, sumit.garg@linaro.org,
        Chuhong Yuan <hslester96@gmail.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        kgdb-bugreport@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kdb: Cleanup math with KDB_CMD_HISTORY_COUNT
Message-ID: <20200520160847.dpvut45zjd5msz6w@holly.lan>
References: <20200507161125.1.I2cce9ac66e141230c3644b8174b6c15d4e769232@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200507161125.1.I2cce9ac66e141230c3644b8174b6c15d4e769232@changeid>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 07, 2020 at 04:11:46PM -0700, Douglas Anderson wrote:
> From code inspection the math in handle_ctrl_cmd() looks super sketchy
> because it subjects -1 from cmdptr and then does a "%
> KDB_CMD_HISTORY_COUNT".  It turns out that this code works because
> "cmdptr" is unsigned and KDB_CMD_HISTORY_COUNT is a nice power of 2.
> Let's make this a little less sketchy.
> 
> This patch should be a no-op.
> 
> Signed-off-by: Douglas Anderson <dianders@chromium.org>

Applied, thanks!
