Return-Path: <SRS0=52rg=4G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38FA4C34022
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 01:04:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0717021D56
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 01:04:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="t7E12jpY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726240AbgBRBET (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Feb 2020 20:04:19 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:41280 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726069AbgBRBET (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Feb 2020 20:04:19 -0500
Received: by mail-ed1-f66.google.com with SMTP id c26so22788026eds.8
        for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2020 17:04:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=9gXLEZ5ZhSnhgaidTQOmUSGs9WESowTEVEZTOgiNxIs=;
        b=t7E12jpYNqt4Kh4sfYkY1RbyYlTCJKuJFtNia/hecGoi97Q1vLeLbpxZJ08igDLGPH
         ftO3ZbVBwVooIq0xLBPb7H2NadgBuxhFCFhfEgdbQNUNPoOIjH0jFoUEFUizEg6cfAR4
         zfq0gjlLufVMYRd61QD3Vb/uMIvfi3HreBWi4mvm+cYzgWVW+14DQX4mf8VPWTSXr2DN
         t42NpTB7BAF/c9Tg5TJRlsH1dIF7lVsWyirfXDMPFXzCdILOcDrRvfld3APh+CQU2Z56
         T5FA4ShyeddFs3psK8tLetVz4dNaW4QP+Ds2+1fdlX9xYL60NMpTk7N/RKqa+DIotwfP
         aj7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=9gXLEZ5ZhSnhgaidTQOmUSGs9WESowTEVEZTOgiNxIs=;
        b=nfLCA6AF6n1qnkYnKq7jh9FNR+0QEmleXdddZC/aV/8NrO85FmMmXYbKkLl55JPdFx
         Y1Lu5S9f0GYaa/afHyDGu/7pFYmWQQN8FKcRQ4UkZez+EzioQdFKBFN+Fa9snWjk4K3D
         jp4pCqX7v8fynqT+TcxoTj7Dff+Hxqv5dnOIr3Btd4VbfJhef97FozCUJfQh0vUQwUxu
         PKkkUOvob0/w3yeQwo4dqlKCr3PK3ty+wm7N5/U6dvoZTO2I7vAiTAEylYi9cTyus+Ki
         61bVmbf4kuTxj2qjgLjgRU19aYqpnKgJ+GhHDqej6Vj15KpH5FK8IicgfEg47T2CyvFv
         GOdg==
X-Gm-Message-State: APjAAAVXhNGjlZeUofAj6f1KrXNx/j+NkyFp9b2UG4AEKmmL2dY+DbbU
        CVPKHeobCJP4vGYzvY6ot7+7R8UFzJfCcWoueeyDNmIqktM=
X-Google-Smtp-Source: APXvYqyFdnrL83tno+l4popM6qcYzpeWwHKkq9JybkA7fGz4IgQzEbT0Af58xS7Ww/1KPO7rHJFPmnoT6nCZCw+PaPo=
X-Received: by 2002:a50:fd15:: with SMTP id i21mr16495124eds.12.1581987857474;
 Mon, 17 Feb 2020 17:04:17 -0800 (PST)
MIME-Version: 1.0
References: <20200218002015.204302-1-lrizzo@google.com>
In-Reply-To: <20200218002015.204302-1-lrizzo@google.com>
From:   Luigi Rizzo <lrizzo@google.com>
Date:   Mon, 17 Feb 2020 17:04:06 -0800
Message-ID: <CAMOZA0Jow_OjcwKKgvSQHYjet3G49Yz1z3F-imodNvSs1Tw2dg@mail.gmail.com>
Subject: Re: [PATCH v2] kretprobe: percpu support
To:     linux-kernel@vger.kernel.org, naveen.n.rao@linux.ibm.com,
        anil.s.keshavamurthy@intel.com, David Miller <davem@davemloft.net>,
        mhiramat@kernel.org, gregkh@linuxfoundation.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 17, 2020 at 4:20 PM Luigi Rizzo <lrizzo@google.com> wrote:
>
> kretprobe uses a list protected by a single lock to allocate a
>

Apologies, ignore v2 since it was missing some bits.
I have posted an updated v3

luigi
