Return-Path: <SRS0=s8dx=5M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99E37C43331
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 06:04:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 62CE820714
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 06:04:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726465AbgC0GEQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Mar 2020 02:04:16 -0400
Received: from isilmar-4.linta.de ([136.243.71.142]:47730 "EHLO
        isilmar-4.linta.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726096AbgC0GEQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Mar 2020 02:04:16 -0400
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
Received: from light.dominikbrodowski.net (brodo.linta [10.1.0.102])
        by isilmar-4.linta.de (Postfix) with ESMTPSA id 70C482000AE;
        Fri, 27 Mar 2020 06:04:14 +0000 (UTC)
Received: by light.dominikbrodowski.net (Postfix, from userid 1000)
        id 90D4120C0B; Fri, 27 Mar 2020 06:28:11 +0100 (CET)
Date:   Fri, 27 Mar 2020 06:28:11 +0100
From:   Dominik Brodowski <linux@dominikbrodowski.net>
To:     "Wangshaobo (bobo)" <bobo.shaobowang@huawei.com>
Cc:     mark.rutland@arm.com, hch@infradead.org, cj.chengjian@huawei.com,
        huawei.libin@huawei.com, xiexiuqi@huawei.com,
        yangyingliang@huawei.com, guohanjun@huawei.com, wcohen@redhat.com,
        linux-kernel@vger.kernel.org, mtk.manpages@gmail.com,
        wezhang@redhat.com
Subject: Re: [PATCH v2] sys_personality: Add a optional arch hook
 arch_check_personality() for common sys_personality()
Message-ID: <20200327052811.GA55291@light.dominikbrodowski.net>
References: <20200109133634.176483-1-bobo.shaobowang@huawei.com>
 <20200110054551.GA352443@light.dominikbrodowski.net>
 <ec8e957b-9fd2-3956-f9c6-338ee7178951@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ec8e957b-9fd2-3956-f9c6-338ee7178951@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 25, 2020 at 06:27:33PM +0800, Wangshaobo (bobo) wrote:
> ping...
> 
> this issue still exists, I am looking forward to your attention.
> 
> 在 2020/1/10 13:45, Dominik Brodowski 写道:
> > On Thu, Jan 09, 2020 at 09:36:34PM +0800, Wang ShaoBo wrote:
> > > currently arm64 use __arm64_sys_arm64_personality() as its default
> > > syscall. But using a normal hook arch_check_personality() can reject
> > > personality settings for special case of different archs.
> > > 
> > > Signed-off-by: Wang ShaoBo <bobo.shaobowang@huawei.com>
> > Reviewed-by: Dominik Brodowski <linux@dominikbrodowski.net>

should probably go upstream through the arm treee?

Thanks,
	Dominik
