Return-Path: <SRS0=pusq=BO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4528C433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 05:34:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C308E2067D
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 05:34:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729294AbgHDFeC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Aug 2020 01:34:02 -0400
Received: from mx2.suse.de ([195.135.220.15]:41578 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727862AbgHDFeC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Aug 2020 01:34:02 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 04B0AACB5;
        Tue,  4 Aug 2020 05:34:16 +0000 (UTC)
Subject: Re: [PATCH v3 08/11] swiotlb-xen: remove XEN_PFN_PHYS
To:     Stefano Stabellini <sstabellini@kernel.org>,
        boris.ostrovsky@oracle.com, konrad.wilk@oracle.com
Cc:     xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
        hch@infradead.org,
        Stefano Stabellini <stefano.stabellini@xilinx.com>
References: <alpine.DEB.2.21.2007101521290.4124@sstabellini-ThinkPad-T480s>
 <20200710223427.6897-8-sstabellini@kernel.org>
From:   =?UTF-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>
Message-ID: <6a96e4a3-295c-8974-6d4e-16aadc7c8ce7@suse.com>
Date:   Tue, 4 Aug 2020 07:33:59 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200710223427.6897-8-sstabellini@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11.07.20 00:34, Stefano Stabellini wrote:
> From: Stefano Stabellini <stefano.stabellini@xilinx.com>
> 
> XEN_PFN_PHYS is only used in one place in swiotlb-xen making things more
> complex than need to be.
> 
> Remove the definition of XEN_PFN_PHYS and open code the cast in the one
> place where it is needed.
> 
> Signed-off-by: Stefano Stabellini <stefano.stabellini@xilinx.com>

Reviewed-by: Juergen Gross <jgross@suse.com>


Juergen
