Return-Path: <SRS0=3CHW=6C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D95D4C2D0EF
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Apr 2020 11:13:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B1F7021D7E
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Apr 2020 11:13:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NxShl3oz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725985AbgDRLNO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Apr 2020 07:13:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725857AbgDRLNO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Apr 2020 07:13:14 -0400
Received: from mail-io1-xd43.google.com (mail-io1-xd43.google.com [IPv6:2607:f8b0:4864:20::d43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBB50C061A0C
        for <linux-kernel@vger.kernel.org>; Sat, 18 Apr 2020 04:13:13 -0700 (PDT)
Received: by mail-io1-xd43.google.com with SMTP id y17so5321617iow.9
        for <linux-kernel@vger.kernel.org>; Sat, 18 Apr 2020 04:13:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=AKMSMR1+WcKScxmI8ZwhCHzKARdDK8BPgfIVeOPP3NQ=;
        b=NxShl3oz6Q30kTK3NvrVwK2Aeje3puDPaUPaSuFIf+Tul0fzP52Uj2eNBDCNhmJ1Bf
         P4t9J8zInqnHnw9rRB8zBIRWk0Ehte+z33Iu3W1o6PLQD4ErCsfrY0upRyXgdRityTuW
         nUP/WIIDLdSfQdZsSqKpu183FPXq7LATHzX5XGzZWHtRednZ9l8XKeXHWyXPcDbndZ9Y
         xbQnfydroKws/JpGJdyt9f/7Jw4iPai1p7MWrXH2LpimAMYPdT5Ul2xUtW1MTKMVvF1W
         UiQFx5voHiArwoqz7yVkD/Gq6VSZxbz0mT6588bzvH+ev2ealVPGere0mh+zVSQgoebZ
         YgZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=AKMSMR1+WcKScxmI8ZwhCHzKARdDK8BPgfIVeOPP3NQ=;
        b=oIVkpmkbuGJqjS5PQr+Iqe12ObG5qiySEHibZGgz9+1YLDCxXLtOp7aRiYI47Dx9yj
         h0LSqGqCci7I0z7SqowICARJm+trShrg6r8HcEVoiBJMUWaSgo+bjfeUP5afbnzZ5Vvr
         pPWrDL4boLAMr1TxELOsyBHs2bgvX/32nL9wno2py9iaZanwyUNbo7yilaDOG71vPrHD
         Yy9e1wIzANJ0BljfKe3lYwfmUiLUGAEja5eVNGfVSpRQMlDqMwg4bg7ZLBril3eZGwck
         yE+QPzeI1XyHfGVJHNwfQgsVrmx+lpafMjv5YMdL7NjwTI7JqnJJCE25ElXu3y4azG+H
         vulw==
X-Gm-Message-State: AGi0Pua6/BM55g8Ky4B7ew/G72ZV8Gl017EsnAQlT+7vsK8Z6/aNFhBp
        EpH8TQhKxmSacqQz/peS9N3HP7nsjY9LrA/hMTQ=
X-Google-Smtp-Source: APiQypI6ME07ywIOTKFOnfStd4PcGNqAgLq4WzfXLmCV8qaP5LE3hKSXM4O9rfAAiWR/WBkZhkh/dVK66rSScDxP47Q=
X-Received: by 2002:a02:a68e:: with SMTP id j14mr7422107jam.86.1587208392947;
 Sat, 18 Apr 2020 04:13:12 -0700 (PDT)
MIME-Version: 1.0
References: <CABXGCsN=SNp7Ub3KHmsGrg+5R1g13HMea2+Jw+hTer3g74q21Q@mail.gmail.com>
 <4a9ae285-f126-c83b-b55f-36bd7a4403a0@gmail.com>
In-Reply-To: <4a9ae285-f126-c83b-b55f-36bd7a4403a0@gmail.com>
From:   Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Date:   Sat, 18 Apr 2020 16:13:02 +0500
Message-ID: <CABXGCsNSni7cjufva_n-VZQ4HKY2osBL4JB2kk_z7Pzv2u10MQ@mail.gmail.com>
Subject: Re: BUG: kernel NULL pointer dereference, address: 0000000000000026
 after switching to 5.7 kernel
To:     =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc:     amd-gfx list <amd-gfx@lists.freedesktop.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        "Grodzovsky, Andrey" <Andrey.Grodzovsky@amd.com>,
        "Russell, Kent" <Kent.Russell@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 11 Apr 2020 at 14:56, Christian K=C3=B6nig
<ckoenig.leichtzumerken@gmail.com> wrote:
>
> Yeah, that is a known issue.
>
> You could try the attached patch, but please be aware that it is not
> even compile tested because of the Easter holidays here.
>

Looks good to me, so it's pity that this patch did not exist in the
pull request https://patchwork.kernel.org/patch/11492083/

--
Best Regards,
Mike Gavrilov.
