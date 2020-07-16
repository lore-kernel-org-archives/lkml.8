Return-Path: <SRS0=y5Sx=A3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCC41C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 13:07:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9F0302065F
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 13:07:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cCv/Msoh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728316AbgGPNHb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jul 2020 09:07:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726537AbgGPNH3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jul 2020 09:07:29 -0400
Received: from mail-qv1-xf41.google.com (mail-qv1-xf41.google.com [IPv6:2607:f8b0:4864:20::f41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 793C4C061755
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jul 2020 06:07:29 -0700 (PDT)
Received: by mail-qv1-xf41.google.com with SMTP id ed14so2647903qvb.2
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jul 2020 06:07:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yTCgb6pNfriHa7QdwxnKN0JEx+SnNfgA6oWTF7AfWbo=;
        b=cCv/Msoh8UW7Bm1Ew8GT4XIMHQ5AJwvGTe8s9LT94fF+PJeTQgsP+v5v1GAmtbExv4
         AZSIzhBLiBCorjt2hS6uoOZf3czaI3ZFMgL0smOQJjeSTYT/fXqHwrKG7qIY1e+MVnF1
         pdhbZMbDN4UFVQ7ArTXFQ1Wj7wV9UKXSdeZrHyxP6hN+L11P7Ft/kzJocP8n4wn9TRDl
         UR5G/QfuxcTytcAFVRnxVNxv8I13sJI6+uh+bcHqlhKRRdjngerDzHOHo5qC/55+MmTF
         Fcw0EL5Pk2ZUydhrgaAjpwPsvCd18e8CY8m0lkfnhfJaYQeKi8qj3zqARNnlmdcy5qDt
         yW4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yTCgb6pNfriHa7QdwxnKN0JEx+SnNfgA6oWTF7AfWbo=;
        b=GmjjPdyfoOi3legAGj2uEckX+NGSO/T+eX4RSpmOEmKRYvkeOI6yQ9bc4nyjsCo93V
         ST9MZYGm6Bh6J25Grcb6y88wRKMOopeAfHh83KUfwxlStYOyhhsOJGZy1dRCdyLwqjQm
         rM+xH1IjBcKconT+QtGcGvOPjaGeZqUdalXg/LfTm/aTj63jh8rJyiNpKos2Va7SneE6
         K7VzHPM5AaknAIjo/7IgEMHPQ8vzuRoRmxxbSEGT6a8Jbx7qNmT0crAzZRLhwC2OJWzD
         uwRcNem7KmF2oNRnvDG7v5q++w4uB8duCKb77jMLPLsfcqNC4W3Yz1F6rXN2s20YsNbm
         6whQ==
X-Gm-Message-State: AOAM533h1SSV7vOjnSvL5pvhqXkNaF1RY5IpzcFAd4NIQZlwUvT3E3gm
        hRcWxUlXKQC0+Fbbly/Xy4ezjszTTc5S1FYx508=
X-Google-Smtp-Source: ABdhPJzn1A/7btlIYG1X8bKeCTor+oIvCx7P+mI1jm4vqroo6Gd9feuKoyUcA12m6b+vBd3k4GzVkMJZVa3kylzK+iM=
X-Received: by 2002:ad4:4cc3:: with SMTP id i3mr4073553qvz.114.1594904848734;
 Thu, 16 Jul 2020 06:07:28 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1594886530.git.zong.li@sifive.com> <628efa24c79a493e39ce6ef13017ae52eaf13388.1594886530.git.zong.li@sifive.com>
In-Reply-To: <628efa24c79a493e39ce6ef13017ae52eaf13388.1594886530.git.zong.li@sifive.com>
From:   Pekka Enberg <penberg@gmail.com>
Date:   Thu, 16 Jul 2020 16:07:12 +0300
Message-ID: <CAOJsxLHrOjaUVUASz067_VX8tYV2DZgR6pvK4V07+ZvhSophPQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] riscv: Fix build warning for mm/init
To:     Zong Li <zong.li@sifive.com>
Cc:     Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 16, 2020 at 4:06 PM Zong Li <zong.li@sifive.com> wrote:
>
> Add static keyword for resource_init, this function is only used in this
> object file.
>
> The warning message as follow (with W=1 build):
>
> arch/riscv/mm/init.c:520:13:
> warning: no previous prototype for 'resource_init' [-Wmissing-prototypes]
>
> Signed-off-by: Zong Li <zong.li@sifive.com>

Reviewed-by: Pekka Enberg <penberg@kernel.org>

- Pekka
