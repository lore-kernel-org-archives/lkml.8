Return-Path: <SRS0=Zj89=5W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00726C2BA17
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 18:54:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C72B820719
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 18:54:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="CLkT2dXb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726444AbgDFSyA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Apr 2020 14:54:00 -0400
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:12612 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725957AbgDFSyA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Apr 2020 14:54:00 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5e8b7a620000>; Mon, 06 Apr 2020 11:52:18 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Mon, 06 Apr 2020 11:53:59 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Mon, 06 Apr 2020 11:53:59 -0700
Received: from DRHQMAIL107.nvidia.com (10.27.9.16) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 6 Apr
 2020 18:53:59 +0000
Received: from rcampbell-dev.nvidia.com (172.20.13.39) by
 DRHQMAIL107.nvidia.com (10.27.9.16) with Microsoft SMTP Server (TLS) id
 15.0.1473.3; Mon, 6 Apr 2020 18:53:58 +0000
Subject: Re: [PATCHv2 1/8] khugepaged: Add self test
To:     "Kirill A. Shutemov" <kirill@shutemov.name>,
        <akpm@linux-foundation.org>, Andrea Arcangeli <aarcange@redhat.com>
CC:     Zi Yan <ziy@nvidia.com>, Yang Shi <yang.shi@linux.alibaba.com>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
References: <20200403112928.19742-1-kirill.shutemov@linux.intel.com>
 <20200403112928.19742-2-kirill.shutemov@linux.intel.com>
From:   Ralph Campbell <rcampbell@nvidia.com>
X-Nvconfidentiality: public
Message-ID: <71529d58-e51d-4f36-037d-42e60dd5a8ff@nvidia.com>
Date:   Mon, 6 Apr 2020 11:53:56 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20200403112928.19742-2-kirill.shutemov@linux.intel.com>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 DRHQMAIL107.nvidia.com (10.27.9.16)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1586199138; bh=g8U9PZuvcH5w4xLQj2gvKeqt5LcgIWXHcVElJKQcRw0=;
        h=X-PGP-Universal:Subject:To:CC:References:From:X-Nvconfidentiality:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=CLkT2dXb750W1QoqQPrPP2Ccskw+S6FlQrEi56Cxpi/s26/v1eaQxteeuzNJaSI79
         9FoyU3EuIr7geDBdcUspaeucGcP5wpUisVzHBk5wjYxzKYea9kNEQWJb7NrbHjHvfA
         9jzh6gvXAOxMc7N1oa3dKhJ9W0nlYchji+fm4OHB2qt4SHQR6jUqb3e+/gZM2tH/T6
         j+OpzkO+//pMMn1EjUeq3/UPT5BoyfsxijanARsQDOefBfJBa9laR7cJnayjUprlwg
         a29OCmki2ynnvWcW1RBs1KcajCzQXLtRP2lYI+UPNL8QpTzqlas8f1NYBY4z9QGZab
         qX9dMd8BzYSRQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 4/3/20 4:29 AM, Kirill A. Shutemov wrote:
> The test checks if khugepaged is able to recover huge page where we
> expetect to do so. It only covers anon-THP for now.
> 
> Currenlty the test shows few failures. They are going to be addressed by
> the following patches.
> 
> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>

One minor nit below but otherwise looks OK.
Reviewed-by: Ralph Campbell <rcampbell@nvidia.com>


> +
> +static void collapse_signle_pte_entry(void)
> +{

Shouldn't this be collapse_single_pte_entry()?
(and change the places where it is called)
