Return-Path: <SRS0=87nF=CT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55156C433E2
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 20:07:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0D7F8221E2
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 20:07:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599768447;
	bh=6Bv/xRpK7lXv8kGKs6UsDHew8tkn3fnGwO/OFA+kgEQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=zIAZbyx9/gSo+Kgclmrlgr4T6IkdQaaYRXjoXzyx752ZoNRmlq4F0VyoLtwczH5Iz
	 EDstKbiHRBAJWZWtzrUiOEh7RG8RwvGpuC/wh4WmbeV7y1tTm1f1PKnVO3sSuLKauH
	 710oEIefE/c4mjmdtAiPfQAOtoGMUUSi/Trzd2JI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727052AbgIJUHT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Sep 2020 16:07:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:39150 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726603AbgIJUDK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 16:03:10 -0400
Received: from kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com (unknown [163.114.132.6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E4818221E2;
        Thu, 10 Sep 2020 20:03:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599768190;
        bh=6Bv/xRpK7lXv8kGKs6UsDHew8tkn3fnGwO/OFA+kgEQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=UstcIQyQwsfgmh7G+5PXmYkfLmQyXYuLZ/kbFq7VcHRC0q1Vt4wX06h+30q7Q3Pbh
         UN5qqULIj/MQpQu1DvQdSjd8x1kxiJaMHI9NFe7j1+groINMJS+BVG4HsxdOlI0mUU
         ZfqwPBL17w4NhgmKbk+6lRiRmwvpM5Bo4nV1RkzE=
Date:   Thu, 10 Sep 2020 13:03:07 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Oded Gabbay <oded.gabbay@gmail.com>
Cc:     linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        SW_Drivers@habana.ai, gregkh@linuxfoundation.org,
        davem@davemloft.net, Omer Shpigelman <oshpigelman@habana.ai>
Subject: Re: [PATCH 05/15] habanalabs/gaudi: add NIC Ethernet support
Message-ID: <20200910130307.5dee086b@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
In-Reply-To: <20200910161126.30948-6-oded.gabbay@gmail.com>
References: <20200910161126.30948-1-oded.gabbay@gmail.com>
        <20200910161126.30948-6-oded.gabbay@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 10 Sep 2020 19:11:16 +0300 Oded Gabbay wrote:
> +module_param(nic_rx_poll, int, 0444);
> +MODULE_PARM_DESC(nic_rx_poll,
> +	"Enable NIC Rx polling mode (0 = no, 1 = yes, default no)");

If your chip does not support IRQ coalescing you can configure polling
and the timeout via ethtool -C, rather than a module parameter.
