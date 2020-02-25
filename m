Return-Path: <SRS0=NmTw=4N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5191FC35E01
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 17:40:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 279762082F
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 17:40:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="vLp0hdjA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731305AbgBYRkb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Feb 2020 12:40:31 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:44866 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730934AbgBYRk2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Feb 2020 12:40:28 -0500
Received: by mail-ot1-f66.google.com with SMTP id h9so266475otj.11
        for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2020 09:40:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iYtNZ1xT6uFxT8TBLjArkPtxeHvwasJTNpB6uOAhuuM=;
        b=vLp0hdjATiQFiYDWcV8uCuBKu/MDvQb4xSQ1J2o3Vxgi7RVy4e9ZsEWQQ575qDQTRW
         9Ew2R9vixKS3jn2cv6NlgWjfNAW6YIUurfP3C1fbwdwSoXA1YM/2EqIpb0ey5EVAye/2
         g7YFbsboxePJx3dlbwa2HI/49qSkNpDa3LJOffu0GP+ve/NRc8lQB3owKvwOeviY2mj4
         8eEE3QNGJ5yB88CHoSMU34so4iDVao/D5iWnq7tGoTPXsH1XupjeGJmpGiRQZtCG9hVm
         NR3A1af0MhepiT/G397PMavZQD/g6sbtFzQouSzq8W+0QnYrE5g1H1jpC0v0pok7NBHK
         rRuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iYtNZ1xT6uFxT8TBLjArkPtxeHvwasJTNpB6uOAhuuM=;
        b=LTf2pPWrjGGgINwQ4+BnZvWgAwxMBp77VdKEDDAhNKW78jWIa7cTwZL0hGOMfVsRzQ
         V0mJoAucnRzxYKc7tlY9oHqHjM9SYs2hbeWqfawiiWV/ObjwCH19ZVHphmYozK/EAynz
         G3rDZy2cFzqVUHrcPaZpiDTfVGgFNPQ2YQwP7HFj2Lqx0aZ1+C5HnmDniufVZjS+xdh/
         Q+YVA0l7Vc0+SzQBvNqR/IqUf9DTqaGccoWSmDOkO9Nk8EbG+pEXv4bNeaoEOlmg40f9
         LRwQx8deOXLVTMrmS6OEHhikrw1fBUQUu+uNvD2eb4aRYKhb3S2m+gfifUjjRy/7lg3N
         8vrw==
X-Gm-Message-State: APjAAAU93+wAY7+ihZZvJcjEAT0btPfgSqlkGGqvKGbSvmHs9eMySk71
        SmNZY/CaByM1tYcC28dU2+0N2a//EPKKfPMBirUeHw==
X-Google-Smtp-Source: APXvYqwGTSmHP8luhoLnsu9zg2hn84azyAtuqIl0pEBs9Aisv3xWMqq2Kqhgt07QP/Tmo0fTgzoRihjhPo9DWyzmYmA=
X-Received: by 2002:a9d:64d8:: with SMTP id n24mr42748771otl.71.1582652428399;
 Tue, 25 Feb 2020 09:40:28 -0800 (PST)
MIME-Version: 1.0
References: <20200225161927.hvftuq7kjn547fyj@kili.mountain> <20200225162055.amtosfy7m35aivxg@kili.mountain>
In-Reply-To: <20200225162055.amtosfy7m35aivxg@kili.mountain>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Tue, 25 Feb 2020 09:40:17 -0800
Message-ID: <CAPcyv4h99vYcxgJ_9NKtYbhAGsifTG0JCRYq-j2t_CQinHZVcw@mail.gmail.com>
Subject: Re: [PATCH 2/2] libnvdimm: Out of bounds read in __nd_ioctl()
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 25, 2020 at 8:21 AM Dan Carpenter <dan.carpenter@oracle.com> wrote:
>
> The "cmd" comes from the user and it can be up to 255.  It it's more
> than the number of bits in long, it results out of bounds read when we
> check test_bit(cmd, &cmd_mask).  The highest valid value for "cmd" is
> ND_CMD_CALL (10) so I added a compare against that.
>
> Fixes: 62232e45f4a2 ("libnvdimm: control (ioctl) messages for nvdimm_bus and nvdimm devices")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

Looks good, applied.
