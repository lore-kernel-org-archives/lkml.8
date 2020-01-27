Return-Path: <SRS0=1cir=3Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81284C2D0DB
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jan 2020 18:17:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 408CD214AF
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jan 2020 18:17:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="VmkxZx7r"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726444AbgA0SRV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jan 2020 13:17:21 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:35916 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725828AbgA0SRV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jan 2020 13:17:21 -0500
Received: by mail-qt1-f193.google.com with SMTP id t13so7722858qto.3
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jan 2020 10:17:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=content-transfer-encoding:from:mime-version:subject:date:message-id
         :references:cc:in-reply-to:to;
        bh=H0vXK67+oGRk9o9l8RLmztHaP5aIkeAR8XI0InnlAdw=;
        b=VmkxZx7rR4jyhk3oNN0A4XJ3rXz9icpoNz5NRQqSunNYTLzjySAkZditLPRjzsNx/z
         0QtE+umERJcVZZv7JdGx3Ucx9aDG5kZAtt7csozqHZBjKkqMbUiCxSCMpmPqGuYWdGXP
         6rA8e5L09NP2PjkfzBtDcbx3sVG+KwS3yw6FsWaRrIQ43qYFJLyy+kv2dWYkJlxzTiKG
         Q9/QfRAfLEAwbMvdLoc+dFrgrw+wX7snqTkF81Qa56TR2XVa69b3FZcyyly9aw0pZg+H
         GlrV4CRld2aR5IfXD6T2uKNgTQACWerD6ldeSPHYEC2fGcESHImD89zLpzGUbtfst2mc
         qWoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=H0vXK67+oGRk9o9l8RLmztHaP5aIkeAR8XI0InnlAdw=;
        b=KFPZBVWCJtjdz6GIncNUhF+1iCXzRx5G8T+QXHUbHib/gSyDr4R74fiXiRaKvnhovC
         FXfVGrPfhtw2TcAFwmbnb5E1/luzC19iCK2YAvH56dPCLybehWR0Kv3Yqh5cZGrietl6
         03bywJTFIUFZ3JD4f9JlubPWuYafdgVxX0j4RpO6oBVoVmj+UIAVehA2oHwXbsVm/P9w
         8/Pum5KYpmK00lCL4CykLDl+iQQJIEt3/rtCwd6fp4DKmihTNqaRQk+UkMXP6Fl0llBP
         oonh0uMVIyAqEcvLeyOlq6vaT1PeFwXEz/16dkZp7pEM9RzgEzm5edVb2A8xPllgumw6
         KV8g==
X-Gm-Message-State: APjAAAUhbpEJLui0PUAAU6Ksqx1BWcyRAcPp2JGYqnEp1m5Jl871FOd1
        ZTQJMtMHBw+tNslEFG2sBnv5k5ZlqwtZbg==
X-Google-Smtp-Source: APXvYqwefJtTiBmdzBaof1Ae/agBKz2BgRCUSBP1dePt3x+Aq3NQY7KIeICOMGBb6HN28GdJ1MvWLA==
X-Received: by 2002:aed:3e53:: with SMTP id m19mr17288476qtf.387.1580149040133;
        Mon, 27 Jan 2020 10:17:20 -0800 (PST)
Received: from [192.168.1.183] (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id o6sm9945160qkk.53.2020.01.27.10.17.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Jan 2020 10:17:19 -0800 (PST)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Qian Cai <cai@lca.pw>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH] mm: mempolicy: use VM_BUG_ON_VMA in queue_pages_test_walk()
Date:   Mon, 27 Jan 2020 13:17:18 -0500
Message-Id: <1221B3C6-6A3B-4427-92DD-25AD54FF6BB5@lca.pw>
References: <1579068565-110432-1-git-send-email-yang.shi@linux.alibaba.com>
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <1579068565-110432-1-git-send-email-yang.shi@linux.alibaba.com>
To:     Yang Shi <yang.shi@linux.alibaba.com>
X-Mailer: iPhone Mail (17C54)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Jan 15, 2020, at 1:09 AM, Yang Shi <yang.shi@linux.alibaba.com> wrote:
>=20
> The VM_BUG_ON() is already used by queue_pages_test_walk(), it sounds
> better to dump more debug information by using VM_BUG_ON_VMA() to help
> debugging.

What=E2=80=99s the problem this is trying to resolve? Was there an existing b=
ug would trigger this?=
