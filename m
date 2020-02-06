Return-Path: <SRS0=za8s=32=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84378C352A2
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 23:56:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 506682068E
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 23:56:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="a57dANPf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726810AbgBFX4B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Feb 2020 18:56:01 -0500
Received: from mail-qv1-f65.google.com ([209.85.219.65]:40239 "EHLO
        mail-qv1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726502AbgBFX4B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Feb 2020 18:56:01 -0500
Received: by mail-qv1-f65.google.com with SMTP id dp13so161358qvb.7
        for <linux-kernel@vger.kernel.org>; Thu, 06 Feb 2020 15:55:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=content-transfer-encoding:from:mime-version:subject:date:message-id
         :references:cc:in-reply-to:to;
        bh=wfPvgghFf2DMJhy7eadDruUT5v7p4a/ZvJyom2rl9Po=;
        b=a57dANPf8EWe3YJhbkTClCTBrBFUaDTCV0iV+QivehVRNEcg9CL/EUY32PYUQnanJZ
         qAzSgKf3ZALLRbngIhfGb5khLDd4cZLBKBYOIsLHWu9wpRn0F02jcdIso2EQEtxYwFXD
         FXr8EHoW2dOr9Rvm97hVP8bmnP57sf/vycWbKg4phZaJtH9czqcZosnW6nsyGtCqFjsr
         xghw1RHZozmBj0TmviYOv+IbIcyllNfCu45HlGDdY6LrrzE7MRsWN4ApDgdOwMsilcoS
         qb64I8/Jh2crWOx+Ob5amurO0GDUyzrVxeIdm3PztalA+wU1/jBYFpbeiUw//k4CZlpp
         BjYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=wfPvgghFf2DMJhy7eadDruUT5v7p4a/ZvJyom2rl9Po=;
        b=Fih3S4J7XPn6J5iAs9mMhqkg9YcnhiayFq4PO6jHsdvf6e9+0bDfPY19wldnxP9+Wz
         jSp8B5lH6D2yBwHww/LyTNoBtgqls9C0BNxFxC8oeR3WNQjCvXrMVKM1px8emuJ+h7+0
         hrGLkb/u80QzjXchk4beSvu8Vg8LTg5+9BZRRfHfzztNBU9KoexFgcwzfub96WU/XxLb
         ZkSqEolGD6U5zdDNh20tsbWWYpAbylySWyQfVcjvl69pqVygDlHu28j/PF2CFlciZSTf
         GjWkkIPG5nhQHrWyHvLvP6aU2dW40a1U62thDQMIF5rIalbB6RZI44ErsXP5N2slIN2p
         1oUg==
X-Gm-Message-State: APjAAAXox0P6fCHv10nXCIOpGFFwrN9v3mnD5qt+XdPCvaWBUOccA8n9
        VNksGtX2HrfX+upeEk11ejxCBA==
X-Google-Smtp-Source: APXvYqyLv1a07nLKvYHfyJJThCFq1CF4peeEnd3zHiXWJDV3fk3XprrXrJa7fXlpLb6KzkW2DUC5HQ==
X-Received: by 2002:ad4:4f47:: with SMTP id eu7mr4615264qvb.69.1581033358641;
        Thu, 06 Feb 2020 15:55:58 -0800 (PST)
Received: from [192.168.1.183] (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id g77sm429615qke.129.2020.02.06.15.55.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Feb 2020 15:55:58 -0800 (PST)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Qian Cai <cai@lca.pw>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH] mm: fix a data race in put_page()
Date:   Thu, 6 Feb 2020 18:55:57 -0500
Message-Id: <B1A2958B-5FB4-458B-8BE7-73047790CE0B@lca.pw>
References: <079c4429-8a11-154d-cf5c-473d2698d18d@nvidia.com>
Cc:     Jan Kara <jack@suse.cz>, David Hildenbrand <david@redhat.com>,
        akpm@linux-foundation.org, ira.weiny@intel.com,
        dan.j.williams@intel.com, elver@google.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <079c4429-8a11-154d-cf5c-473d2698d18d@nvidia.com>
To:     John Hubbard <jhubbard@nvidia.com>
X-Mailer: iPhone Mail (17D50)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Feb 6, 2020, at 6:34 PM, John Hubbard <jhubbard@nvidia.com> wrote:
>=20
> * data_race(): there is no race on the N bits worth of page zone number da=
ta. There
>  is only a perceived race, due to tools that look at word-level granularit=
y.

I=E2=80=99d like to think this from the compiler level. There is a data race=
 from the compiler load and store point of view. It is just in the case it i=
s harmless to affect the actual code logic.=
