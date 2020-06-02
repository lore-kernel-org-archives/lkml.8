Return-Path: <SRS0=QAx1=7P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24E86C433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 11:45:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 073B220772
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 11:45:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726371AbgFBLpx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jun 2020 07:45:53 -0400
Received: from mx2.suse.de ([195.135.220.15]:43394 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726007AbgFBLpw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jun 2020 07:45:52 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 075C3AD72;
        Tue,  2 Jun 2020 11:45:54 +0000 (UTC)
Date:   Tue, 2 Jun 2020 13:45:48 +0200
From:   Jiri Bohac <jbohac@suse.cz>
To:     Lianbo Jiang <lijiang@redhat.com>
Cc:     linux-kernel@vger.kernel.org, kexec@lists.infradead.org,
        akpm@linux-foundation.org, ebiederm@xmission.com,
        jmorris@namei.org, mjg59@google.com, dyoung@redhat.com,
        bhe@redhat.com
Subject: Re: [PATCH v2] kexec: Do not verify the signature without the
 lockdown or mandatory signature
Message-ID: <20200602114548.2yevcdfsho4it75u@dwarf.suse.cz>
References: <20200602045952.27487-1-lijiang@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200602045952.27487-1-lijiang@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 02, 2020 at 12:59:52PM +0800, Lianbo Jiang wrote:
> So, here, let's simplify the logic to improve code readability. If the
> KEXEC_SIG_FORCE enabled or kexec lockdown enabled, signature verification
> is mandated. Otherwise, we lift the bar for any kernel image.
> 
> Signed-off-by: Lianbo Jiang <lijiang@redhat.com>

Reviewed-by: Jiri Bohac <jbohac@suse.cz>

-- 
Jiri Bohac <jbohac@suse.cz>
SUSE Labs, Prague, Czechia

