Return-Path: <SRS0=fqu/=3Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BE35C3524D
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 00:32:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 33CF72082E
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 00:32:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="VEKzGAYh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727727AbgBEAcH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Feb 2020 19:32:07 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:34785 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727522AbgBEAcH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Feb 2020 19:32:07 -0500
Received: by mail-lj1-f195.google.com with SMTP id x7so551939ljc.1
        for <linux-kernel@vger.kernel.org>; Tue, 04 Feb 2020 16:32:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FOrKuN0ED2H3+K7/MfL1jj30xOUJqnID7Rv6ou7TKFY=;
        b=VEKzGAYhTb7M/mx+Guc5+woSDVaydZ5An3TOikWW3R1znjKO87uULt/b6/1PZFjpU0
         QwEzhypIiQ/YDXIOpxfBEZVMPN6uvKBU22thp2ABFii1yC6O71wxAXGexpqMWKjBLskb
         1y/pmrlsM03ytGkalYQ8xOVCqcjNRu2oT+qkg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FOrKuN0ED2H3+K7/MfL1jj30xOUJqnID7Rv6ou7TKFY=;
        b=nf1rz5s+SaMB+iY/bOCQc+m0g5TjQNr1lBAIOIxkd4gf/4UJHKHfsL0SqEk1H/uWnU
         HVuUCQafVCUszF5rF9UY7j3kJw0c2yE6uHOKvBcPdD5+W7Zs62uNch/45duY282xvmeg
         V30fadnFdX9TaT83hj3ZEVVICJaSOoFetbWBZrdwAnT5xaxUbYocNn1fwlDR+1zrSG40
         I+YDhgwyprOV5ubSoQXdROjzjo4jqU3b4njghcTYWXpotaxf0czVQe7rNrwgERzgqEmG
         BfHx+hJd2nVgejGKOZidx0nA/mU5JDiNb3XtR9vL+26l7lLM2sED6SA94S6NFFiTHKiv
         QqpQ==
X-Gm-Message-State: APjAAAUjNsizGbbnmnfvjuNnqzFj6gqwLOJ/yXFAsEBQD3LBXEoz6snu
        9CNvYBNH5hqTods8DCvMMi5lTZn/wK4=
X-Google-Smtp-Source: APXvYqwvOh8NDNkNJtK/TIgj3g3DRZUwiekYNrfVYMzy7yHPghh/pjzywVKqtaaTELcHI4jAytCY/g==
X-Received: by 2002:a2e:9052:: with SMTP id n18mr18622722ljg.251.1580862724630;
        Tue, 04 Feb 2020 16:32:04 -0800 (PST)
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com. [209.85.208.174])
        by smtp.gmail.com with ESMTPSA id e25sm11861591ljp.97.2020.02.04.16.32.03
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Feb 2020 16:32:03 -0800 (PST)
Received: by mail-lj1-f174.google.com with SMTP id q8so496426ljj.11
        for <linux-kernel@vger.kernel.org>; Tue, 04 Feb 2020 16:32:03 -0800 (PST)
X-Received: by 2002:a2e:8702:: with SMTP id m2mr18879289lji.278.1580862722808;
 Tue, 04 Feb 2020 16:32:02 -0800 (PST)
MIME-Version: 1.0
References: <1580796831-18996-1-git-send-email-mkshah@codeaurora.org> <1580796831-18996-3-git-send-email-mkshah@codeaurora.org>
In-Reply-To: <1580796831-18996-3-git-send-email-mkshah@codeaurora.org>
From:   Evan Green <evgreen@chromium.org>
Date:   Tue, 4 Feb 2020 16:31:26 -0800
X-Gmail-Original-Message-ID: <CAE=gft7gPS+hhnDP+uTn3is6s9=Nspbb4PL0bZ025Tq1Zpth8Q@mail.gmail.com>
Message-ID: <CAE=gft7gPS+hhnDP+uTn3is6s9=Nspbb4PL0bZ025Tq1Zpth8Q@mail.gmail.com>
Subject: Re: [PATCH 2/3] soc: qcom: rpmh: Update rpm_msgs offset address and
 add list_del
To:     Maulik Shah <mkshah@codeaurora.org>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Doug Anderson <dianders@chromium.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Lina Iyer <ilina@codeaurora.org>, lsrao@codeaurora.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 3, 2020 at 10:14 PM Maulik Shah <mkshah@codeaurora.org> wrote:
>
> rpm_msgs are copied in continuously allocated memory during write_batch.
> Update request pointer to correctly point to designated area for rpm_msgs.
>
> While at this also add missing list_del before freeing rpm_msgs.
>
> Signed-off-by: Maulik Shah <mkshah@codeaurora.org>
> ---
>  drivers/soc/qcom/rpmh.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/soc/qcom/rpmh.c b/drivers/soc/qcom/rpmh.c
> index c3d6f00..04c7805 100644
> --- a/drivers/soc/qcom/rpmh.c
> +++ b/drivers/soc/qcom/rpmh.c
> @@ -65,7 +65,7 @@ struct cache_req {
>  struct batch_cache_req {
>         struct list_head list;
>         int count;
> -       struct rpmh_request rpm_msgs[];
> +       struct rpmh_request *rpm_msgs;
>  };
>
>  static struct rpmh_ctrlr *get_rpmh_ctrlr(const struct device *dev)
> @@ -327,8 +327,10 @@ static void invalidate_batch(struct rpmh_ctrlr *ctrlr)
>         unsigned long flags;
>
>         spin_lock_irqsave(&ctrlr->cache_lock, flags);
> -       list_for_each_entry_safe(req, tmp, &ctrlr->batch_cache, list)
> +       list_for_each_entry_safe(req, tmp, &ctrlr->batch_cache, list) {
> +               list_del(&req->list);
>                 kfree(req);
> +       }
>         INIT_LIST_HEAD(&ctrlr->batch_cache);

Hm, I don't get it. list_for_each_entry_safe ensures you can traverse
the list while freeing it behind you. ctrlr->batch_cache is now a
bogus list, but is re-inited with the lock held. From my reading,
there doesn't seem to be anything wrong with the current code. Can you
elaborate on the bug you found?

>         spin_unlock_irqrestore(&ctrlr->cache_lock, flags);
>  }
> @@ -377,10 +379,11 @@ int rpmh_write_batch(const struct device *dev, enum rpmh_state state,
>                 return -ENOMEM;
>
>         req = ptr;
> +       rpm_msgs = ptr + sizeof(*req);
>         compls = ptr + sizeof(*req) + count * sizeof(*rpm_msgs);
>
>         req->count = count;
> -       rpm_msgs = req->rpm_msgs;
> +       req->rpm_msgs = rpm_msgs;

I don't really understand what this is fixing either, can you explain?
