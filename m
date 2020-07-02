Return-Path: <SRS0=maQP=AN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73152C433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 19:35:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3F8BE20674
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 19:35:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="P9akivtI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726112AbgGBTfS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jul 2020 15:35:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726065AbgGBTfR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jul 2020 15:35:17 -0400
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85950C08C5DD
        for <linux-kernel@vger.kernel.org>; Thu,  2 Jul 2020 12:35:17 -0700 (PDT)
Received: by mail-qt1-x841.google.com with SMTP id h23so22260455qtr.0
        for <linux-kernel@vger.kernel.org>; Thu, 02 Jul 2020 12:35:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vMrH7R2vPu3gkZfS+H01Ns/eTvn1XgH9B+3gDwbQS4Q=;
        b=P9akivtIL9OPr+h9G/Fq5VLuJfJuZFU9rGS5Kge23ZeuGNoA7zxXxtsApOQceAsw6N
         zYga8mXjNlZK5Mvgsfb2jIlScoppXGu5RrJ7BabzEAKp2/k0ffQlljRgcBnNx9qC5h0R
         O6EofygNMl6l/Y/YTNgauT/ckyh7h2hTXn/7ydmUbt3BpC45FLu+/6eN9d3Ywp//sb+V
         PAExWPcfBHhw5fS0k41aMb/xwvvM0qaTW+fsjqhA5ynNn9ftJRVGxBZ3pSo7GYlHaEmO
         u6+mrBt7xUelVphkgi6lJCm+2qg8x9rWmdTENTwnBzTCnzfoqXMge5J9Vq5JWYibWus2
         n8FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vMrH7R2vPu3gkZfS+H01Ns/eTvn1XgH9B+3gDwbQS4Q=;
        b=U4joqZiwMrc1uUH7nDoAbWRZsdNEMzLO/D8OvqK91fp+Vbvw1o+/inG3df5fwfyVm8
         cUzhqT6fPWpfOhpQwVGaA9m+kCHBjFTb9PWwbVK8LCs07UnPtcG2hf040v2tsdfnRapJ
         t30dRXPOZQTD+Vu3oxZfUPejmmUmKmzxpf98Ui1yBYkv60RBpVMOjrrf6SN6+XNurCaD
         7zulWtXxFQMph66UECkrndlR3WQKUkLhso16aP3s60U4EWOPEkzDgjuQj2vCZc2E48/2
         JeYiHbbgiCEyyHb+YYily/TI0lR6raOPAAJwL5Luuo/BNvdNHcuJpjr23tse8X6Q6y/7
         XxRA==
X-Gm-Message-State: AOAM531cTfaGR8VpPDhaO8Rye+XUnm64MSb/hpKBouMoPMDdmPmLbJoE
        Fom+Uq45aGiYlAE3xhf0FDTROHKvgi0xH35fdk47OycDT9Y=
X-Google-Smtp-Source: ABdhPJzY/c3o9AVELnYdRdQGQ5SGjtPMLSoJTN+S95yvl3HqiQ5qFGNKsi2igRT/SjswXN+cm3rHq5ojlC52o2axmxA=
X-Received: by 2002:ac8:7a90:: with SMTP id x16mr32827703qtr.233.1593718516626;
 Thu, 02 Jul 2020 12:35:16 -0700 (PDT)
MIME-Version: 1.0
References: <20200629211801.C3D7095C0900@us180.sjc.aristanetworks.com>
 <20200629171612.49efbdaa@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
 <CA+HUmGjHQPUh1frfy5E28Om9WTVr0W+UQVDsm99beC_mbTeMog@mail.gmail.com> <61CC2BC414934749BD9F5BF3D5D940449874358A@ORSMSX112.amr.corp.intel.com>
In-Reply-To: <61CC2BC414934749BD9F5BF3D5D940449874358A@ORSMSX112.amr.corp.intel.com>
From:   Francesco Ruggeri <fruggeri@arista.com>
Date:   Thu, 2 Jul 2020 12:35:05 -0700
Message-ID: <CA+HUmGhfxYY5QiwF8_UYbp0TY-k3u+cTYZDSqV1s=SUFnGCn8g@mail.gmail.com>
Subject: Re: [PATCH] igb: reinit_locked() should be called with rtnl_lock
To:     "Kirsher, Jeffrey T" <jeffrey.t.kirsher@intel.com>
Cc:     Jakub Kicinski <kuba@kernel.org>,
        David Miller <davem@davemloft.net>,
        open list <linux-kernel@vger.kernel.org>,
        netdev <netdev@vger.kernel.org>,
        "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Do not worry about the other Intel drivers, I have our developers looking at each of our drivers for the locking issue.
>
> @David Miller - I am picking up this patch

There seems to be a second race, independent from the
original one, that results in a divide error:

kworker         reboot -f       tx packet

igb_reset_task
                __igb_shutdown
                rtnl_lock()
                ...
                igb_clear_interrupt_scheme
                igb_free_q_vectors
                adapter->num_tx_queues = 0
                ...
                rtnl_unlock()
rtnl_lock()
igb_reinit_locked
igb_down
igb_up
netif_tx_start_all_queues
                                dev_hard_start_xmit
                                igb_xmit_frame
                                igb_tx_queue_mapping
                                Panics on
                                r_idx % adapter->num_tx_queues

Using in igb_reset_task a logic similar to the one in
ixgbe_reset_subtask (bailing if __IGB_DOWN or __IGB_RESETTING
is set) seems to avoid the panic.
That logic was first introduced in ixgbe as part of commit
2f90b8657ec ('ixgbe: this patch adds support for DCB to the
kernel and ixgbe driver').
Both fixes seem to be needed.
