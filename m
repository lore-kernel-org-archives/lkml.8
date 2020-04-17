Return-Path: <SRS0=3W8M=6B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 638A3C2BB1D
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 07:48:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 40D722063A
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 07:48:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729527AbgDQHsh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Apr 2020 03:48:37 -0400
Received: from mx2.suse.de ([195.135.220.15]:56056 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728925AbgDQHsg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Apr 2020 03:48:36 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id BE889AF0D;
        Fri, 17 Apr 2020 07:48:33 +0000 (UTC)
Subject: Re: [PATCH] MAINTAINERS: Update PARAVIRT_OPS_INTERFACE and
 VMWARE_HYPERVISOR_INTERFACE
From:   =?UTF-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>
To:     Deep Shah <sdeep@vmware.com>, linux-kernel@vger.kernel.org
Cc:     pv-drivers@vmware.com, thellstrom@vmware.com,
        virtualization@lists.linux-foundation.org
References: <20200416234520.GA1700@prme-mon-cfl-mlw-07>
 <84f719e9-3af0-4242-f50b-990371d4768a@suse.com>
Message-ID: <155feefc-598b-023d-1e78-56cbce9f4a1a@suse.com>
Date:   Fri, 17 Apr 2020 09:48:33 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <84f719e9-3af0-4242-f50b-990371d4768a@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17.04.20 08:22, Jürgen Groß wrote:
> On 17.04.20 01:45, Deep Shah wrote:
>> Thomas Hellstrom will be handing over VMware's maintainership of these
>> interfaces to Deep Shah.
>>
>> Signed-off-by: Deep Shah <sdeep@vmware.com>
>> Acked-by: Thomas Hellstrom <thellstrom@vmware.com>
> 
> Acked-by: Juergen Gross <jgross@suse.com>

BTW, I can carry this patch through the Xen tree if nobody else wants to
take it...


Juergen
