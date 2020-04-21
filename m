Return-Path: <SRS0=8uoY=6F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1540AC54FCC
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 20:17:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DA814206B8
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 20:17:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="FeweVQjh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726328AbgDUURf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Apr 2020 16:17:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725930AbgDUURe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Apr 2020 16:17:34 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 875DAC0610D5
        for <linux-kernel@vger.kernel.org>; Tue, 21 Apr 2020 13:17:34 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id np7so24030pjb.1
        for <linux-kernel@vger.kernel.org>; Tue, 21 Apr 2020 13:17:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=lZc2+7DRgAsbezSSNe7oioLU23tyafgFH/vdWcacCz0=;
        b=FeweVQjh8oiWTFR5SXCzZBaTLKgwwHNi8q+ouI4VFB4xICUiV1xiYsuZo8hhp3yO07
         pV0JrV3uCy4GeVN6jMuZAIHnnxA77d4xF0dwXMUiV3WZQt65QQ95YcFfXYkp3aDiQdAy
         p82ndXRfSbPS0Zsb6Y90BAE/aKbhhe+t+YFzU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=lZc2+7DRgAsbezSSNe7oioLU23tyafgFH/vdWcacCz0=;
        b=hVy5c+cstVaEnc0nV+I3QsO5IgdhzXQZJQ75chmBfoTXHPcQHHmqGUnuTlxdImSXxe
         exXCU7QJD1ZESqMPDc73vSmc92ncOkNdbPs/gv2/VWkVqN/PAmmQm7OCNftfEqWM5kVS
         OpZbQDRVerdpEetRViZBUftiECcE4z08Fjlhm0amCKfiZTaJtjbw2DkWwrG+oU+fGdvR
         9JreyXXM+s5G1gG7hI3U2IVs1I4Vjrd+Vv5lr5RYEHis5aFnsHXg9MjifU+euWXO31Sj
         0UdggEBKkE55hEwDDRG9QfM2YOmV8tc9ngTtS8B2SvlMflhKdd9LI3TaiQ/i9gs1xgrC
         ILYw==
X-Gm-Message-State: AGi0Pubm+zJXQQM7xMQbs7Yos4aVDR8lI0lOcNNsLw5+6oGirSl0I9Hu
        YDgD4U8u/imx4iWCzVQPYc3ZLw==
X-Google-Smtp-Source: APiQypI+LyriAApJbHZH/T0REdTsFVryDminGf7v51A37cYBeeQQVF/c/zkYrJ0htoZ5vGoByyJJaA==
X-Received: by 2002:a17:902:6947:: with SMTP id k7mr23464993plt.222.1587500254136;
        Tue, 21 Apr 2020 13:17:34 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id e4sm3129642pjv.30.2020.04.21.13.17.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2020 13:17:33 -0700 (PDT)
Date:   Tue, 21 Apr 2020 13:17:32 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     Sami Tolvanen <samitolvanen@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] objtool: optimize add_dead_ends for split sections
Message-ID: <202004211315.BE5B8D94FE@keescook>
References: <20200421180724.245410-1-samitolvanen@google.com>
 <20200421180724.245410-4-samitolvanen@google.com>
 <20200421201305.66y2u473htzcuhfu@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200421201305.66y2u473htzcuhfu@treble>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 21, 2020 at 03:13:05PM -0500, Josh Poimboeuf wrote:
> BTW, just curious, what's your use case for -ffunction-sections?  Is it
> for fgkaslr?

Both Sami's LTO+CFI work[1] and Kristen's FGKASLR series use it.

-Kees

[1] https://github.com/samitolvanen/linux/commits/clang-cfi
    https://lwn.net/Articles/810077/

-- 
Kees Cook
