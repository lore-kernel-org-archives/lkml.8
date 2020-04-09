Return-Path: <SRS0=n+Ub=5Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4B4DC2D0EA
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 06:37:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 90C4A20757
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 06:37:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726579AbgDIGhu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Apr 2020 02:37:50 -0400
Received: from mx2.suse.de ([195.135.220.15]:37674 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725765AbgDIGhu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Apr 2020 02:37:50 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 0D9ADAC64;
        Thu,  9 Apr 2020 06:37:49 +0000 (UTC)
Subject: Re: Use of VM_IOREMAP in xenbus
To:     Christoph Hellwig <hch@lst.de>, Wei Liu <wl@xen.org>
Cc:     Bob Liu <bob.liu@oracle.com>,
        "Durrant, Paul" <pdurrant@amazon.com>,
        Konrad Wilk <konrad.wilk@oracle.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org
References: <20200409061846.GA30241@lst.de>
From:   =?UTF-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>
Message-ID: <8074b77d-d784-95ee-8d47-069827855876@suse.com>
Date:   Thu, 9 Apr 2020 08:37:48 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200409061846.GA30241@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adjusting recipient list (dropping David, new mail addresses for Wei and
Paul).

On 09.04.20 08:18, Christoph Hellwig wrote:
> Hi Wei,
> 
> commit ccc9d90a9a8b5 ("xenbus_client: Extend interface to support
> multi-page ring") addes a use of vmap in what is now
> xenbus_map_ring_valloc_hvm, and uses the VM_IOREMAP flag that is
> only really intended for implementing ioremap.  Do you remember
> what the reason is that this flag was used?
> 

Juergen
