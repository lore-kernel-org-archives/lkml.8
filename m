Return-Path: <SRS0=dAmO=AZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02393C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 16:57:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CBA852242B
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 16:57:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="e/jd97eW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728674AbgGNQ5d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jul 2020 12:57:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728087AbgGNQ5c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 12:57:32 -0400
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DD33C061755
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jul 2020 09:57:32 -0700 (PDT)
Received: by mail-qt1-x82e.google.com with SMTP id u12so13299973qth.12
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jul 2020 09:57:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=E3Vl7lXSBLWRQLzjq6qw4dXugUjlNDno9t87QTaRNu0=;
        b=e/jd97eWsfnhXcOfbPxvUA+fSF6vtBv9lA2qsuFpBKBa+cOOL77M+iMH8yFXaNsJKM
         Z7G7MftWez2ilmY0eZMxzC1Xn6tkUvmGfwRoiV3wUUShWTPO5q0DW/yl6kngEVX+a5Rq
         KKUNV6+wv1M673kR4ubROjD2V5KsZqu5lm688PDuSQQf+LsCra1jAQ1jdZVNG9IBkwkj
         J+ApKuOnrfukqsYJeuVtFdcmtFxBmZoCoIo8TJ9FQGlTaliSz0gKQv8Mvk7fE8gHJi+U
         wQa7i1j22EXT6qdoSRnnj68US5iux5SBGzJbhjjtGbL5j8TiBbm7wmOo4ee7Wz8snecW
         Ln7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=E3Vl7lXSBLWRQLzjq6qw4dXugUjlNDno9t87QTaRNu0=;
        b=S9MZnB63Lym3IDcO5jeyrYObntBZXRoA1R8zqnEIJE4JPrFAJaVW7T+y33CppH+qwX
         bWyBOCeLuIdXVtk8dzt5vEbY/95h3m8fDYaiwn/4xzNtvrgAYzRAwKQkUKXiLmqyBT9r
         T2jtp19icjsV96iLOTkCI9Pd8P9Sjslq1QhiK/GGJ/B7WuEpNHJsqaTy9DrHad+KvO70
         H6pIP42fp1YHoKtuK3J37seQeOkng3/N7RGYhlKb509fz1PJHAOCxhIDRY60qaly4oIX
         YZgshqY987sNZS+HLiFPXd5JGxBl5PYGJg6TuW4dGxZ0z7XopybcUm/Jz77UF+pFqVXU
         HWyw==
X-Gm-Message-State: AOAM533GIVs5/S7XwxN6RrJLLyMUAx+Upb7NVKGm9DsVyVa+RsGMYY5B
        VGhzOc5uYFEF6p0iGiGYjT0eoaHXHCRmNnn8HuONhw==
X-Google-Smtp-Source: ABdhPJw0CD9SLAjxqsroSJ51+sFvUvuFOAqdYaR2xPOV6t+zCv5g0MwJt8rFds99Lanqzk82SvaygXSshoV8Ip7EuuA=
X-Received: by 2002:ac8:6989:: with SMTP id o9mr5851059qtq.50.1594745851384;
 Tue, 14 Jul 2020 09:57:31 -0700 (PDT)
MIME-Version: 1.0
References: <20200714025417.A25EB95C0339@us180.sjc.aristanetworks.com> <20200714131413.GJ23073@quack2.suse.cz>
In-Reply-To: <20200714131413.GJ23073@quack2.suse.cz>
From:   Francesco Ruggeri <fruggeri@arista.com>
Date:   Tue, 14 Jul 2020 09:57:18 -0700
Message-ID: <CA+HUmGhSMtus0-a5Z75zu2GUGce6GhSks8ATDQK2h7CiNRFmpA@mail.gmail.com>
Subject: Re: soft lockup in fanotify_read
To:     Jan Kara <jack@suse.cz>
Cc:     open list <linux-kernel@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org, amir73il@gmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for the replies and workaround suggestions!

Francesco
