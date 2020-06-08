Return-Path: <SRS0=Cjtw=7V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF434C433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 05:35:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A82BB204EC
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 05:35:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728470AbgFHFfS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jun 2020 01:35:18 -0400
Received: from mx2.suse.de ([195.135.220.15]:36546 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726929AbgFHFfR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jun 2020 01:35:17 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id A702EB26C;
        Mon,  8 Jun 2020 05:35:19 +0000 (UTC)
Subject: Re: [PATCH] MAINTAINERS: Update PARAVIRT_OPS_INTERFACE and
 VMWARE_HYPERVISOR_INTERFACE
To:     Deep Shah <sdeep@vmware.com>, linux-kernel@vger.kernel.org
Cc:     virtualization@lists.linux-foundation.org, pv-drivers@vmware.com,
        thellstrom@vmware.com
References: <20200416234520.GA1700@prme-mon-cfl-mlw-07>
From:   =?UTF-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>
Message-ID: <aec7c17f-859b-348d-6a8b-00c3bf5e5e53@suse.com>
Date:   Mon, 8 Jun 2020 07:35:15 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200416234520.GA1700@prme-mon-cfl-mlw-07>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17.04.20 01:45, Deep Shah wrote:
> Thomas Hellstrom will be handing over VMware's maintainership of these
> interfaces to Deep Shah.
> 
> Signed-off-by: Deep Shah <sdeep@vmware.com>
> Acked-by: Thomas Hellstrom <thellstrom@vmware.com>
Pushed to xen/tip.git for-linus-5.8


Juergen
