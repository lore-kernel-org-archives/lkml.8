Return-Path: <SRS0=29S8=54=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74A0CC2D0EC
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Apr 2020 20:01:15 +0000 (UTC)
Received: from vger.kernel.org (unknown [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C6D720708
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Apr 2020 20:01:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JTEXhzej"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C6D720708
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728000AbgDLUBN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 12 Apr 2020 16:01:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.18]:58912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727315AbgDLUBN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Apr 2020 16:01:13 -0400
Received: from mail-il1-x143.google.com (mail-il1-x143.google.com [IPv6:2607:f8b0:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F292BC0A3BF0;
        Sun, 12 Apr 2020 13:01:11 -0700 (PDT)
Received: by mail-il1-x143.google.com with SMTP id f82so3456234ilh.8;
        Sun, 12 Apr 2020 13:01:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TvhPeCmmnSWMBc5XbJ9SjdVL7VHorubIMkvHTiVNJ08=;
        b=JTEXhzejqUauPkZSbQUpbPnV3cv9WUHapcXVaWDoEO9FKrmbamMMnMqeYHgzqF+D20
         bm4fIrRt90pQJKXjUfOCYOuoAF1uq+/8ZO0Dj0c0YqXXs0odJW83EH4Aw8ylgDWKIc11
         l/KFHd6OkP/otAEQOQ1SfixTepIGE5IhPhxJleGkAcqnc62k0ytHE0BcU0Ujy+lAbea5
         PqCRmSF826avj9HC77/pOQgfMfBrwKuJAqh4CIS+6MqchpovBGOg+pilOneCBkbOarBL
         8qKPpYCLJOEPMZ7Bc5Q/S117BSecvLKLdxzK31qic1lY+CzEByp5SBvJiRHoFJDewGTJ
         LYhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TvhPeCmmnSWMBc5XbJ9SjdVL7VHorubIMkvHTiVNJ08=;
        b=INPd8uGc0B2rL1wZp3n6b1QWi5jgKI+PIcns/t5PyejTIdUiGTGsmNLPURxfeyR2C8
         Zz0hO/dB51QGpF0qqn0rCnLeXO1cjWW1Uqo0X63av0JI1zd6W1xf9HEFf4bLAFTmHsOp
         aPieSbsFN6Ufh8peGoAM+3/TMZgEUfgtYtxkAXNlK0FvU++Q5ngRahCT3LEeVQSL2Hz4
         4ZBMI+J7Qb7eWmzJJfiuOUVY6VMOf1LonmD6rvk9IREd2ESfwUUj538Haafo8NMVqVCu
         M48og4SSs/Z6EejpeRF2sdqNmXQlxlyTQ+sBl2fLB5+w5gZgP9GufTkIu3/MvN02catc
         N97Q==
X-Gm-Message-State: AGi0PuaB5/Goah24IVFV9iQwubSbfEJR+Zt8OUGGaRzMT+7ACEPahRyW
        k1FTAlJEdVQ2/F0prSb+zUsRjvRICBnf4T5EdBo=
X-Google-Smtp-Source: APiQypKL14NvS04Jb1uZwV3CGwrgh4ktwp1jmI9X/WfN3QBCe051D5y/Uw+rcNV8w9ObtgTPAw3zFbAZg6RO3mWrMEk=
X-Received: by 2002:a92:1d5b:: with SMTP id d88mr14314302ild.111.1586721670454;
 Sun, 12 Apr 2020 13:01:10 -0700 (PDT)
MIME-Version: 1.0
References: <CABXGCsPpD+ExaeA6v+gSPPgtxcVzpKLWJNwGPPDKGFkPCv5kDg@mail.gmail.com>
 <1d02e4f3-8d83-4c55-bce2-f5aa4af2e363@linux.intel.com> <20200410142920.GA936997@rani.riverdale.lan>
 <20200411020051.20448-1-hdanton@sina.com>
In-Reply-To: <20200411020051.20448-1-hdanton@sina.com>
From:   Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Date:   Mon, 13 Apr 2020 01:00:59 +0500
Message-ID: <CABXGCsM0L=9REjqZmKYDgLXk_pq5UH8pW1=n67a0PhqmzZFR1Q@mail.gmail.com>
Subject: Re: [Bug report] Kernel 5.7 become unbootable
To:     Hillf Danton <hdanton@sina.com>
Cc:     Arvind Sankar <nivedita@alum.mit.edu>,
        Like Xu <like.xu@linux.intel.com>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        linux-x86_64@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 11 Apr 2020 at 07:01, Hillf Danton <hdanton@sina.com> wrote:
>
> After taking a look at d8a26d8fc37c5b
> (drm/mm: revert "Break long searches in fragmented address spaces")
>

I applied the mentioned patch from the patchwork and the system has
been working stably already for 24 hours without any BUG messages in
kernel logs, thanks.

https://patchwork.freedesktop.org/patch/359278/

All problems solved.

--
Best Regards,
Mike Gavrilov.
