Return-Path: <SRS0=8grS=CJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.1 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E905EC433E6
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 17:47:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ABC5120866
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 17:47:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ldoEDMh1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727998AbgHaRr6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 31 Aug 2020 13:47:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726226AbgHaRry (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Aug 2020 13:47:54 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB090C061573
        for <linux-kernel@vger.kernel.org>; Mon, 31 Aug 2020 10:47:53 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id bh1so3399338plb.12
        for <linux-kernel@vger.kernel.org>; Mon, 31 Aug 2020 10:47:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=P829i5Iw79pY5XzrVknioognLQa7eeRlaAv36ZVo67A=;
        b=ldoEDMh1VddXNaWZRPrfsEXG5+Zl0OBnn1+eLfeuSKwavLg0dcI+H0wVlxcuStFM8O
         nRHK8Cg+TDh/AwwKhubsCBz14AnQgdxOxRajQKX50RNKzX1u/i/doBKS4IlqsjcsMUj5
         YqmwcaTOtetuZSPQlJMpKCa3AX8CEJX8xiiv210o0vz2NnN6XBeo5kElEBVzVoypdZQM
         mpvPsW/RrHTTyJrqDIAkkr6sh/sZtBltwONXf5HrfPjnYaQzXlIdS8y8V1uWdzbGX2sU
         jkHAyMkrV7npXAEMbiD93gBqwIjSDhfD9iVSTEG8EILtSp2yWqV2jsh/zfLVgjxCuDSA
         +9nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=P829i5Iw79pY5XzrVknioognLQa7eeRlaAv36ZVo67A=;
        b=XS8IB+15xpwZUESTxX9K9tomu/9GEdFMpnUCOJ+XyVy4VefhrVQmThXFBRbq9kBpK7
         U14lhakgC6xmo7Xl16QbZnBD5J2wqiLG+eEndMx9T+1TFZO08JQBkeinm2chVbPmcug4
         Fh7v4N7JYFe441SqfBiCpG3qdsIbadxWqsZ6Gq3QMo9a3WPIkaexlaVNkewBx2hk0OZ1
         0wZiU0iV5dBSxtd1ERm5o50VQB9aKK091O3pWQl/b9S1dMYY+nAJia3SRGnhiH30Uij9
         WPIvLqYTaHit2N0DcrUadFczgO6AeQvbIDJJUGvk5Prx0WUn9bGsE/wxHz2KivomA5ZG
         7Puw==
X-Gm-Message-State: AOAM532UG7OOTEd+ItqZcTlyYvsueKf+6qEe15Cig98/9hdSu5Ix6mrM
        vRuEpVMMWyaPLyQc/gERyg870O7SS8smbMexnIaiVQ==
X-Google-Smtp-Source: ABdhPJzvRJ7aNmtvcSGmX2ruQahuZVdBW/pE0eXak3IkWeu4IDPVyPGWeVx87YTz/fWB/bjdL5+DRNg0P9DH9AxZguE=
X-Received: by 2002:a17:902:9f8a:: with SMTP id g10mr1879533plq.158.1598896073003;
 Mon, 31 Aug 2020 10:47:53 -0700 (PDT)
MIME-Version: 1.0
References: <20200829153515.3840-1-trix@redhat.com>
In-Reply-To: <20200829153515.3840-1-trix@redhat.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Mon, 31 Aug 2020 10:47:42 -0700
Message-ID: <CAKwvOd=+X2AakX3kTYCvyug-MK_Y+atDbkDSRxA0pUfOatQ3mA@mail.gmail.com>
Subject: Re: [PATCH] soundwire: fix error handling
To:     trix@redhat.com
Cc:     Vinod Koul <vkoul@kernel.org>, yung-chuan.liao@linux.intel.com,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Sanyog Kale <sanyog.r.kale@intel.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        shreyas.nc@intel.com, alsa-devel@alsa-project.org,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 29, 2020 at 8:35 AM <trix@redhat.com> wrote:
>
> From: Tom Rix <trix@redhat.com>
>
> clang static analysis flags this problem
>
> stream.c:844:9: warning: Use of memory after
>   it is freed
>         kfree(bus->defer_msg.msg->buf);
>               ^~~~~~~~~~~~~~~~~~~~~~~
>
> This happens in an error handler cleaning up memory
> allocated for elements in a list.
>
>         list_for_each_entry(m_rt, &stream->master_list, stream_node) {
>                 bus = m_rt->bus;
>
>                 kfree(bus->defer_msg.msg->buf);
>                 kfree(bus->defer_msg.msg);
>         }
>
> And is triggered when the call to sdw_bank_switch() fails.
> There are a two problems.
>
> First, when sdw_bank_switch() fails, though it frees memory it
> does not clear bus's reference 'defer_msg.msg' to that memory.
>
> The second problem is the freeing msg->buf. In some cases
> msg will be NULL so this will dereference a null pointer.
> Need to check before freeing.
>
> Fixes: 99b8a5d608a6 ("soundwire: Add bank switch routine")
> Signed-off-by: Tom Rix <trix@redhat.com>
> ---
>  drivers/soundwire/stream.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/soundwire/stream.c b/drivers/soundwire/stream.c
> index 37290a799023..6e36deb505b1 100644
> --- a/drivers/soundwire/stream.c
> +++ b/drivers/soundwire/stream.c
> @@ -717,6 +717,7 @@ static int sdw_bank_switch(struct sdw_bus *bus, int m_rt_count)
>         kfree(wbuf);
>  error_1:
>         kfree(wr_msg);
> +       bus->defer_msg.msg = NULL;

This fix looks correct to me because L668 sets `bus->defer_msg.msg =
wr_msg;`, but on error L719 frees `wr_msg`, so now
`bus->defer_msg.msg` is a dangling pointer.

>         return ret;
>  }
>
> @@ -840,9 +841,10 @@ static int do_bank_switch(struct sdw_stream_runtime *stream)
>  error:
>         list_for_each_entry(m_rt, &stream->master_list, stream_node) {
>                 bus = m_rt->bus;
> -
> -               kfree(bus->defer_msg.msg->buf);
> -               kfree(bus->defer_msg.msg);
> +               if (bus->defer_msg.msg) {
> +                       kfree(bus->defer_msg.msg->buf);
> +                       kfree(bus->defer_msg.msg);
> +               }

I'd prefer a conditional check for each, but sdw_ml_sync_bank_switch()
has this same pattern, so it looks like the lifetime of these two
match.

Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

Thanks for the patch!

>         }
>
>  msg_unlock:
> --
> 2.18.1
>


-- 
Thanks,
~Nick Desaulniers
