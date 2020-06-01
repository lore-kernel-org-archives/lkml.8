Return-Path: <SRS0=8+oI=7O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AE39C433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 12:38:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 59F6A20679
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 12:38:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="XW4pchmy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726110AbgFAMiS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jun 2020 08:38:18 -0400
Received: from mout.web.de ([212.227.15.3]:43893 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725838AbgFAMiO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jun 2020 08:38:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1591015087;
        bh=IVf4hudrlbKj+KRTCcrAWHzDwVeED3tTOft/0bbn7WM=;
        h=X-UI-Sender-Class:Cc:Subject:From:To:Date;
        b=XW4pchmyx1QLl/aLV7yr83DtbRGEb9OVqZzjtI9rCw+KULlpcu/rHeAV4sfp2zGXd
         0pHxshV188cX8uzsYp9WqKXT1V/xq1ELh6y7tQcVCvrilT2S8GRzTd7/qCJ3IseA5v
         We9qqmXvHOdLjIogfIT+2sW8Rlu6Uy97ooOfDaGM=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([78.49.133.32]) by smtp.web.de (mrweb004
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MPaxV-1jbayV3TmL-004hSO; Mon, 01
 Jun 2020 14:38:06 +0200
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iommu: Improve exception handling in iommu_group_alloc()
From:   Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
To:     Baolin Wang <baolin.wang@linux.alibaba.com>,
        =?UTF-8?B?SsO2cmcgUsO2ZGVs?= <joro@8bytes.org>,
        iommu@lists.linux-foundation.org
Message-ID: <9f8d8308-2056-8e33-7b38-0b7d96e51c3c@web.de>
Date:   Mon, 1 Jun 2020 14:38:05 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:jjZy/qq3MYji+Y3iMCXMt5mvHN2RXqF9PJKSs+9OGxty52SYeH9
 8BZoaXLSkqLa2RVSSDp1dsFeq3uV1NxU2LRkYO9t+51eiiKeCIkXVPfffJJl+krpszkAFyM
 MFaB7EpjJuT+o/5rpfePoaBk9cO/s1J3O7uMd9RJR7hapfleEZ/6UnMVRfox72TyVwhULyd
 JORYnj2l0gT/ffnwo3LZA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:wQGGWyQY5rY=:w9dUPrDQ36CF7o1X1HzNgN
 njtCoQAB9DCQbHCGWKuXkEO/w9bGg9M233GhfXyMxi9f9RHhy3ZWfdUh3UBDgYuNzVnudWgMZ
 p30nIu7SXzw7kLtEK2hwEO1n624xanJj5wzrEp6iMofOAcGZnbuqhQkzgmKgEStiHxNrYYAR4
 5O7I9eWVwVZze8+Be5GDFLQtVIkO3t7pAoN5sKzpnH0OSO6pjBVAO6XpQiOYHv03G90Zrb7th
 nphyBMrGuMnxDUDJXWkG5wnQSEJocBLq6EqHj3wG8p1Fh+2QtFgGVIaOU5KQ5O9Oih4YhjOmh
 9G+cobC+givb8Zl35umXbKxjzl5Ce2Te3fJclcFbVksF1BApBIZ9xsqEndhvVyHa74p3JtGGQ
 Zo58bBA/oKQfQZUZRYS6vK0J+521h5wZch0d/F+TdDPAkrK6iWYaPji/u0z2mW8T9wrYLRpyQ
 3vOVsI/dUAfyEq/QHZch5/z/UXrh68lAbofrpBzDPv4xZFZo4TnSLzXW+a/FZ6NeQUNyBM6ML
 IFcDA2woj8ZYVVUdfBktWQHGJLzD5HTMzaAEw9bR2iB8soenA6wvjQF36lIHAtu1UB9wf1OtT
 QdPkr0aaFlEozCvtc/svV7JDwpkn9UYn9/KJwA+Jpqc5GqnAkOCjP7Y2RfP/xYvurClzoLVy9
 sq1VdQudEuR3VmkKZjh+WD7mkZQCsxoA3TzFpouRysl+TqPfGFLeU25/zSiBgOgubJQ5kAbIY
 fqRno1mN3L2vBckBBlxN62gCoR/t8YAw4hOAjWINxZAfHa6+bMlzb0ZXU6WqQTYGchmp5LAd8
 3ESWdn9HwdeLyo2O0ZiAIqQCpi2pXmC0WjQCKjrtbxODgWsne+f93RmZlehtonZsjfyHtWoYB
 CXPRT8aejsiv3RcZjZ+iSdrmw4RnofzhjmoUVUdOV2VE7LvmT6INUkiUUyYWh6LYLjm4WV657
 yztqi2590MxGuADX1waGQq2Hn5m7FrpbRwD060eo4Cfdab2C4VS1Vh2j1PTW5CFKG8yCYViHb
 er/5kd9/BPG1Kf4ajtJ/DGXdFRGMpMErz9T8vWbKwM8fjvQV2JC9s6yGXWNqD7Myiviwo+QlR
 olX6EeOHzbeReWEW+035FIxY6nNLCa8LkrNFKlbiOwkREhbPpGDTRRb+2EY5mrSN2vFZb+Ruk
 nMcZ3Y1u5TJVR7HvEeTXBMBShLSfAFH2eDa0fTvp1PR2N7ngIXZ8Ox/yqBpsnvy6Kx1jXxKrA
 Mqn6gBpCDrXGSmZfh
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Optimize the error handling to free the resources correctly when
> failed to allocate an iommu group.

* I would not categorise the desired completion of exception handling
  as a software optimisation.

* Would you like to add the tag =E2=80=9CFixes=E2=80=9D to the commit mess=
age?

* I suggest to avoid the specification of duplicate function calls.
  Will it be helpful to add a few jump targets?
  https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/=
Documentation/process/coding-style.rst?id=3D3d77e6a8804abcc0504c904bd6e5cd=
f3a5cf8162#n455

Regards,
Markus
