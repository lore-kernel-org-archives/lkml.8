Return-Path: <SRS0=6raZ=AQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DEB3C433E2
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Jul 2020 15:11:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 044A520737
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Jul 2020 15:11:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="Hbpzh2mk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727987AbgGEPL0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 Jul 2020 11:11:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727839AbgGEPLY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Jul 2020 11:11:24 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44F12C08C5E0
        for <linux-kernel@vger.kernel.org>; Sun,  5 Jul 2020 08:11:24 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id dr13so39776240ejc.3
        for <linux-kernel@vger.kernel.org>; Sun, 05 Jul 2020 08:11:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2tHsNsc85oEMgxfMe/9ECsv9KY90m64bzbMRR9357CU=;
        b=Hbpzh2mkywq3PINoKnKvIeWREaFlJ3B37cTwpnx5RerTgpbuKhSZPwrsl1vLicqVxn
         ppPB4hWBeYerbw9BThTxK+n8qqf2CdjU6s1IapyqlR2OMNy+nRTlEXRsvO55prOmzSfR
         GdJuNL11UHoSywYCM3N0fE+L0KDjyeW5bA0QLIHmCIHZMOCWUhHXaRZ43bxKjdjMI7bD
         l+lzN56NXJzBqSPgPsICGEuAOksqaFb7tK3H4T7GjSYbz1pnMTuBMKKgASJ99mLUoqmU
         dkZrcvT0qaRaKCHuU/YsajwEu9OLxgMbwVVylVTd94Q+LxGxTmDXntTiK6+kU/1BOiQp
         yhkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2tHsNsc85oEMgxfMe/9ECsv9KY90m64bzbMRR9357CU=;
        b=Vvd2nNXQRhc11Rc8SKDeMYc7pIG1+uHI5TPFHG6wzQ4ijda2/icoT51AcqnUeVTuif
         6B7iHiOuuE88tM5vU28OdgxWbYkHX05U3Ewe1N4E5xtqg1MyQCM6u9F+9QkrIM8HEARd
         kTVj9zbeYF+on+k83gSOhyXPBUsKN2HN1e7DMqOGxTYL7wNeFkp78i0GgnrrDxriqPav
         gCaZUiWIP4fdZPYGwYcqOr4X8mN32UDniDvKE/v6BWq84PdDE96du47bjmuWl+60dQLV
         xOwCJGzh+blRc7kFP+IQeskG4Dguya5XXjJklmi8csgq/wfsxtauvTBb0+quYGG1Xkdf
         eF+g==
X-Gm-Message-State: AOAM532vyr3KCaKP5MvqPao4JdTB/VMzh0yTnHxo4JMkxK3zgqFQEM3D
        9yH1dEriCL47aL+ove0qX8mFFnQ6t3Q4aC9FgsoW
X-Google-Smtp-Source: ABdhPJykYYlS6DyRXswVmWtbu7A3Q6Dy8mVKkx1CmIV5P5PACrs0bkv1logTfFs6fMkOIf3NdUb1tBevQz1LKf/qCoI=
X-Received: by 2002:a17:906:aac9:: with SMTP id kt9mr36448175ejb.488.1593961882949;
 Sun, 05 Jul 2020 08:11:22 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1593198710.git.rgb@redhat.com> <4a5019ed3cfab416aeb6549b791ac6d8cc9fb8b7.1593198710.git.rgb@redhat.com>
In-Reply-To: <4a5019ed3cfab416aeb6549b791ac6d8cc9fb8b7.1593198710.git.rgb@redhat.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Sun, 5 Jul 2020 11:11:11 -0400
Message-ID: <CAHC9VhSwMEZrq0dnaXmPi=bu0NgUtWPuw-2UGDrQa6TwxWkZtw@mail.gmail.com>
Subject: Re: [PATCH ghak90 V9 08/13] audit: add containerid support for user records
To:     Richard Guy Briggs <rgb@redhat.com>
Cc:     containers@lists.linux-foundation.org, linux-api@vger.kernel.org,
        Linux-Audit Mailing List <linux-audit@redhat.com>,
        linux-fsdevel@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        netdev@vger.kernel.org, netfilter-devel@vger.kernel.org,
        sgrubb@redhat.com, Ondrej Mosnacek <omosnace@redhat.com>,
        dhowells@redhat.com, simo@redhat.com,
        Eric Paris <eparis@parisplace.org>,
        Serge Hallyn <serge@hallyn.com>, ebiederm@xmission.com,
        nhorman@tuxdriver.com, Dan Walsh <dwalsh@redhat.com>,
        mpatel@redhat.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 27, 2020 at 9:23 AM Richard Guy Briggs <rgb@redhat.com> wrote:
>
> Add audit container identifier auxiliary record to user event standalone
> records.
>
> Signed-off-by: Richard Guy Briggs <rgb@redhat.com>
> Acked-by: Neil Horman <nhorman@tuxdriver.com>
> Reviewed-by: Ondrej Mosnacek <omosnace@redhat.com>
> ---
>  kernel/audit.c | 19 ++++++++++++-------
>  1 file changed, 12 insertions(+), 7 deletions(-)
>
> diff --git a/kernel/audit.c b/kernel/audit.c
> index 54dd2cb69402..997c34178ee8 100644
> --- a/kernel/audit.c
> +++ b/kernel/audit.c
> @@ -1507,6 +1504,14 @@ static int audit_receive_msg(struct sk_buff *skb, struct nlmsghdr *nlh)
>                                 audit_log_n_untrustedstring(ab, str, data_len);
>                         }
>                         audit_log_end(ab);
> +                       rcu_read_lock();
> +                       cont = _audit_contobj_get(current);
> +                       rcu_read_unlock();
> +                       audit_log_container_id(context, cont);
> +                       rcu_read_lock();
> +                       _audit_contobj_put(cont);
> +                       rcu_read_unlock();
> +                       audit_free_context(context);

I haven't searched the entire patchset, but it seems like the pattern
above happens a couple of times in this patchset, yes?  If so would it
make sense to wrap the above get/log/put in a helper function?

Not a big deal either way, I'm pretty neutral on it at this point in
the patchset but thought it might be worth mentioning in case you
noticed the same and were on the fence.

--
paul moore
www.paul-moore.com
