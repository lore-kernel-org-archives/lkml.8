Return-Path: <SRS0=za8s=32=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92E0AC3F68F
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 20:25:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 66E55222C2
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 20:25:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="BuIJ8GW7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727916AbgBFUZo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Feb 2020 15:25:44 -0500
Received: from mail-qv1-f43.google.com ([209.85.219.43]:43881 "EHLO
        mail-qv1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727830AbgBFUZo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Feb 2020 15:25:44 -0500
Received: by mail-qv1-f43.google.com with SMTP id p2so3478120qvo.10
        for <linux-kernel@vger.kernel.org>; Thu, 06 Feb 2020 12:25:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=V+0pNskuD/SO3/Mfw6U/mhfbSMlYPhmeyrODwhcICD0=;
        b=BuIJ8GW7w6Df9mfqCREKzGHB6DpPXsZ4ztoVTFY+qO/azoRbhsE09W4S2obz1HeZnj
         JZamn3QfFjQM344UKbKr3fe0qQy7iwSI3Zzm+fKFrOIIMMbpXodpX2+WhNZn5ykHsSrP
         Fhpvmz8uhh4ivXkl7m6tD4fRlm06bBo9E+9+KU+VcQhqzUPsKzNBtE+RcRZtfuGaVZpg
         YJ63RbE5R2stvs2sTqaVTJxsgFOovWygZyKTjJjA6DeRGP659XZneGjKjk9FzC13SvqX
         c0XTfyCUZ7+UgRUdmHQGcF2fnp5y0t/5EMCEaveITuM6XGr6bRKrytDvV8oN/U2lalJA
         yS1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=V+0pNskuD/SO3/Mfw6U/mhfbSMlYPhmeyrODwhcICD0=;
        b=g/YDi2grfkBCjDBrk1wr+arU95x231POElERRWu9IOsSRKtSkOtOL7CiME7GmRdTEz
         wpi4uenfVk1/f1ABzU9grUbhuAFI1Psfs6VdbCncalTCfpZ9LjRcjbHNLXyih0uZaHSM
         w5WwVU+7dujEMSuDzL9AfRlibHXa9+U1V2n+bEd/6j9ZG2klz+eaa1H7bIWIM0aZAqOZ
         Lua78pUDQqc+4YO/zUHHyB7jTTOolAoVamMf1H/tAMOTUl2+yJ79EBj9XnWgU5PqccuP
         3Idjoale7KmCuFwSUxyKq0CUOzgB/Jesbo5KYq8kjf+HiUxqkLa49tWraaQCKmioFtFl
         qqeA==
X-Gm-Message-State: APjAAAV8FhnWxWwL2kacuHjQsGQH4G8aZCOa49HVzEbhCDd19J7sk2mP
        aGvQ3XBwjnJfuVJlRqlqzP1ZJg==
X-Google-Smtp-Source: APXvYqzCKll75OCN7AjSN8WOJiMDS0hEzPjVuzKSdQb8837HoW/z7IfPuSBWdcD8inIkX07YirveTQ==
X-Received: by 2002:a0c:edb2:: with SMTP id h18mr3898739qvr.94.1581020743007;
        Thu, 06 Feb 2020 12:25:43 -0800 (PST)
Received: from [192.168.1.153] (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id r6sm193031qtm.63.2020.02.06.12.25.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 06 Feb 2020 12:25:42 -0800 (PST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 13.0 \(3608.60.0.2.5\))
Subject: Re: [PATCH -next v2] mm: mark an intentional data race in
 page_zonenum
From:   Qian Cai <cai@lca.pw>
In-Reply-To: <20200206202005.GY8731@bombadil.infradead.org>
Date:   Thu, 6 Feb 2020 15:25:41 -0500
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Marco Elver <elver@google.com>, jhubbard@nvidia.com,
        ira.weiny@intel.com, dan.j.williams@intel.com, jack@suse.cz,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <95A69596-D5F9-41EB-84A0-AE32D17FE320@lca.pw>
References: <20200206183000.913-1-cai@lca.pw>
 <20200206202005.GY8731@bombadil.infradead.org>
To:     Matthew Wilcox <willy@infradead.org>
X-Mailer: Apple Mail (2.3608.60.0.2.5)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Feb 6, 2020, at 3:20 PM, Matthew Wilcox <willy@infradead.org> =
wrote:
>=20
> On Thu, Feb 06, 2020 at 01:30:00PM -0500, Qian Cai wrote:
>> Both the read and write are done only with the non-exclusive mmap_sem
>> held. Since the read only check for a specific bit range (up to 3 =
bits)
>> in the flag but the write here never change those 3 bits, so load
>> tearing would be harmless here. Thus, just mark it as an intentional
>> data races using the data_race() macro which is designed for those
>> situations [1].
>=20
> This changelog makes me think you don't really understand the =
situation.
>=20
> A page never changes its zone number.  The zone number happens to be
> stored in the same word as other bits which are modified, but the zone
> number bits will never be modified by any other write.  So we can =
accept
> a reload of the zone bits after an intervening write and we don't need
> to use READ_ONCE().

Maybe your explanation is better, but I did try to explain the same =
thing.
I=E2=80=99ll let Andrew to decide if he would like to update the commit =
log a bit
with your wording.=
