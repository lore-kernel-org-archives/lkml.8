Return-Path: <SRS0=idZ5=4V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 971BFC3F2CE
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 23:21:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6746C207FD
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 23:21:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="kCr5Lw9O"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388631AbgCDXV5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Mar 2020 18:21:57 -0500
Received: from mail-vs1-f67.google.com ([209.85.217.67]:41682 "EHLO
        mail-vs1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388560AbgCDXV4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Mar 2020 18:21:56 -0500
Received: by mail-vs1-f67.google.com with SMTP id k188so2372172vsc.8
        for <linux-kernel@vger.kernel.org>; Wed, 04 Mar 2020 15:21:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Y5xoFX1FrvW/gV/OR//iEMUc1pw5F5Dc49NbBNslky8=;
        b=kCr5Lw9OiD1ad3gZ8vxx2beaE5NU5NkGGFVM2EBu6aeYCOOejQJV9ZMUvTeDH4/fGQ
         5I03Q/TAEXu0WspP90Fv4ctWhm2tjcRgbHFSPAAP2BpujowrjLXDNEmfV3Hg23T5JpzK
         rK3u9tAoM63qfDXL5smphvkT0dN/03+wED6Q8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Y5xoFX1FrvW/gV/OR//iEMUc1pw5F5Dc49NbBNslky8=;
        b=lSaOQK0hD23TnM8vuEK8IjMCXVPeXD0O2c0cH+l20UqgnTiKmwWV5m2a2xFiBRlmAw
         +ANAFppFGTnDtq3e9wHEDHFnX+e+UThBG7NZsbgzEX+5NtDmRnkjRVm6AyZdmBoW+pSv
         HJs1IvePg79o6FYXcRoXWxoEmVto16065kDkn3diLO5HZw7WZ0u7PHT1jOlLJNMo4DT+
         fFEYHij7iDS08Hm5c1H2axnVFneYGSZkG5op1dc1Vl1VYgoiYX3queVTIdCyFvqrAx/s
         XL1at3SdmCJVGj7861z1IPHqd5m9TXIiqv74k4SroaL7Sd+lRX6n8o1+KQZz+hrSbzTu
         0Yhg==
X-Gm-Message-State: ANhLgQ19c+CpJ2cJlN9D/RjWAIaPAQoqbVlqOzLfPMQaX6q41UfgeU/a
        A8tFEJCsiwg62Fi6R9vxvUvuPvkonJs=
X-Google-Smtp-Source: ADFU+vtiLRH385oy+xgBmOgQUKbujNjiEG6DIXPy4dg7BmSJ+5DXkmLX/bROwQpNCowUYONfqiYhRQ==
X-Received: by 2002:a67:fc14:: with SMTP id o20mr3384835vsq.230.1583364114520;
        Wed, 04 Mar 2020 15:21:54 -0800 (PST)
Received: from mail-vk1-f172.google.com (mail-vk1-f172.google.com. [209.85.221.172])
        by smtp.gmail.com with ESMTPSA id b128sm6507509vsd.9.2020.03.04.15.21.53
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Mar 2020 15:21:53 -0800 (PST)
Received: by mail-vk1-f172.google.com with SMTP id w67so1101410vkf.1
        for <linux-kernel@vger.kernel.org>; Wed, 04 Mar 2020 15:21:53 -0800 (PST)
X-Received: by 2002:a1f:a04f:: with SMTP id j76mr2876781vke.75.1583364113116;
 Wed, 04 Mar 2020 15:21:53 -0800 (PST)
MIME-Version: 1.0
References: <1583238415-18686-1-git-send-email-mkshah@codeaurora.org> <1583238415-18686-3-git-send-email-mkshah@codeaurora.org>
In-Reply-To: <1583238415-18686-3-git-send-email-mkshah@codeaurora.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Wed, 4 Mar 2020 15:21:41 -0800
X-Gmail-Original-Message-ID: <CAD=FV=VOARbQzY_p-SyDFu0mzFROp8nV9E=sraNrykWiySwEpw@mail.gmail.com>
Message-ID: <CAD=FV=VOARbQzY_p-SyDFu0mzFROp8nV9E=sraNrykWiySwEpw@mail.gmail.com>
Subject: Re: [PATCH v10 2/3] soc: qcom: rpmh: Update dirty flag only when data changes
To:     Maulik Shah <mkshah@codeaurora.org>
Cc:     Stephen Boyd <swboyd@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Evan Green <evgreen@chromium.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Andy Gross <agross@kernel.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Lina Iyer <ilina@codeaurora.org>, lsrao@codeaurora.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Mar 3, 2020 at 4:27 AM Maulik Shah <mkshah@codeaurora.org> wrote:
>
> Currently rpmh ctrlr dirty flag is set for all cases regardless of data
> is really changed or not. Add changes to update dirty flag when data is
> changed to newer values. Update dirty flag everytime when data in batch
> cache is updated since rpmh_flush() may get invoked from any CPU instead
> of only last CPU going to low power mode.
>
> Also move dirty flag updates to happen from within cache_lock and remove
> unnecessary INIT_LIST_HEAD() call and a default case from switch.
>
> Fixes: 600513dfeef3 ("drivers: qcom: rpmh: cache sleep/wake state requests")
> Signed-off-by: Maulik Shah <mkshah@codeaurora.org>
> Reviewed-by: Srinivas Rao L <lsrao@codeaurora.org>
> Reviewed-by: Evan Green <evgreen@chromium.org>
> ---
>  drivers/soc/qcom/rpmh.c | 21 +++++++++++++--------
>  1 file changed, 13 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/soc/qcom/rpmh.c b/drivers/soc/qcom/rpmh.c
> index eb0ded0..f28afe4 100644
> --- a/drivers/soc/qcom/rpmh.c
> +++ b/drivers/soc/qcom/rpmh.c
> @@ -133,26 +133,30 @@ static struct cache_req *cache_rpm_request(struct rpmh_ctrlr *ctrlr,
>
>         req->addr = cmd->addr;
>         req->sleep_val = req->wake_val = UINT_MAX;
> -       INIT_LIST_HEAD(&req->list);
>         list_add_tail(&req->list, &ctrlr->cache);
>
>  existing:
>         switch (state) {
>         case RPMH_ACTIVE_ONLY_STATE:
> -               if (req->sleep_val != UINT_MAX)
> +               if (req->sleep_val != UINT_MAX) {
>                         req->wake_val = cmd->data;
> +                       ctrlr->dirty = true;
> +               }

You could maybe avoid a few additional "dirty" cases by changing the
above "if" to:

if (req->sleep_val != UINT_MAX &&
   (req->wake_val != cmd->data)

...since otherwise writing an "ACTIVE_ONLY" thing over and over again
with the same value would keep saying "dirty".


Looking at this code makes me wonder a bit about how it's supposed to
work, though.  Let's look at a sequence of 3 commands called in two
different orders:

rpmh_write(RPMH_WAKE_ONLY_STATE, addr=0x10, data=0xaa);
rpmh_write(RPMH_ACTIVE_ONLY_STATE, addr=0x10, data=0x99);
rpmh_write(RPMH_SLEEP_STATE, addr=0x10, data=0xbb);

==> End result will be a cache entry (addr=0x10, wake=0xaa, sleep=0xbb)


rpmh_write(RPMH_SLEEP_STATE, addr=0x10, data=0xbb);
rpmh_write(RPMH_WAKE_ONLY_STATE, addr=0x10, data=0xaa);
rpmh_write(RPMH_ACTIVE_ONLY_STATE, addr=0x10, data=0x99);

==> End result will be a cache entry (addr=0x10, wake=0x99, sleep=0xbb)


Said another way, it seems weird that a vote for "active" counts as a
vote for "wake", but only if a sleep vote was made beforehand?
Howzat?


Maybe at one point in time it was assumed that wake's point was just
to undo sleep?  That is, if:

state_orig = /* the state before sleep happens */
state_sleep = apply(state_orig, sleep_actions)
state_wake = apply(state_sleep, wake_actions)

The code is assuming "state_orig == state_wake".

...it sorta makes sense that "state_orig == state_wake" would be true,
but if we were really making that requirement we really should have
structured RPMH's APIs differently.  We shouldn't have even allowed
the callers to specify "WAKE_ONLY" state and we should have just
constructed it from the "ACTIVE_ONLY" state.


To summarize:

a) If the only allowable use of "WAKE_ONLY" is to undo "SLEEP_ONLY"
then we should re-think the API and stop letting callers to
rpmh_write(), rpmh_write_async(), or rpmh_write_batch() ever specify
"WAKE_ONLY".  The code should just assume that "wake_only =
active_only if (active_only != sleep_only)".  In other words, RPMH
should programmatically figure out the "wake" state based on the
sleep/active state and not force callers to do this.

b) If "WAKE_ONLY" is allowed to do other things (or if it's not RPMH's
job to enforce/assume this) then we should fully skip calling
cache_rpm_request() for RPMH_ACTIVE_ONLY_STATE.


NOTE: this discussion also makes me wonder about the is_req_valid()
function.  That will skip sending a sleep/wake entry if the sleep and
wake entries are equal to each other.  ...but if sleep and wake are
both different than "active" it'll be a problem.


>                 break;
>         case RPMH_WAKE_ONLY_STATE:
> -               req->wake_val = cmd->data;
> +               if (req->wake_val != cmd->data) {
> +                       req->wake_val = cmd->data;
> +                       ctrlr->dirty = true;

As far as I can tell from the code, you can also avoid dirty if
req->sleep_val == UINT_MAX since nothing will be sent if either
sleep_val or wake_val are UINT_MAX.  Same in the sleep case where we
can avoid dirty if wake_val == UINT_MAX.


> +               }
>                 break;
>         case RPMH_SLEEP_STATE:
> -               req->sleep_val = cmd->data;
> -               break;
> -       default:
> +               if (req->sleep_val != cmd->data) {
> +                       req->sleep_val = cmd->data;
> +                       ctrlr->dirty = true;
> +               }
>                 break;
>         }

I wonder if instead of putting the dirty everywhere above it's better
to cache the old value before the switch, then do:

ctrl->dirty = (req->sleep_val != old_sleep_val ||
  req->wake_val != old_wake_val) &&
  req->sleep_val != UINT_MAX &&
  req->wake_val != UINT_MAX;


-Doug
