Return-Path: <SRS0=ObIu=6N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB019C83000
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 14:00:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 94A0B20731
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 14:00:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=yadro.com header.i=@yadro.com header.b="mzVn/jDG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727824AbgD2OAz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Apr 2020 10:00:55 -0400
Received: from mta-02.yadro.com ([89.207.88.252]:55478 "EHLO mta-01.yadro.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726776AbgD2OAz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Apr 2020 10:00:55 -0400
Received: from localhost (unknown [127.0.0.1])
        by mta-01.yadro.com (Postfix) with ESMTP id C93B6412CC;
        Wed, 29 Apr 2020 14:00:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=yadro.com; h=
        content-type:content-type:content-transfer-encoding:mime-version
        :references:in-reply-to:x-mailer:message-id:date:date:subject
        :subject:from:from:received:received:received; s=mta-01; t=
        1588168851; x=1589983252; bh=PFQ+bnPNNJYx7rujMY9zrWYg2tjFphBQGIb
        XMJn43Q8=; b=mzVn/jDG2iH8Ng5dI4ec/VbIkJPjIRDAbCj/7gUcRhDabcdOLvl
        sdYsGlbLUHe2lqo0hSvgAqrZ0b/gQwaro2FX7nzxiCe0T4Xuhlwj4CXaV30irYwG
        X3SSYZtOjbL/Ogl2pNAL02ywEpHc4o4Nk8OuamdYlyYY8++Fzn3XOs2E=
X-Virus-Scanned: amavisd-new at yadro.com
Received: from mta-01.yadro.com ([127.0.0.1])
        by localhost (mta-01.yadro.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id LvlLtNU3-tSf; Wed, 29 Apr 2020 17:00:51 +0300 (MSK)
Received: from T-EXCH-02.corp.yadro.com (t-exch-02.corp.yadro.com [172.17.10.102])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mta-01.yadro.com (Postfix) with ESMTPS id D14BC4C848;
        Wed, 29 Apr 2020 17:00:50 +0300 (MSK)
Received: from localhost (172.17.204.212) by T-EXCH-02.corp.yadro.com
 (172.17.10.102) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id 15.1.669.32; Wed, 29
 Apr 2020 17:00:51 +0300
From:   Roman Bolshakov <r.bolshakov@yadro.com>
To:     <martin.petersen@oracle.com>
CC:     <bvanassche@acm.org>, <dave.jiang@intel.com>, <dvyukov@google.com>,
        <gregkh@linuxfoundation.org>,
        <ksummit-discuss@lists.linuxfoundation.org>,
        <linux-kernel@vger.kernel.org>, <linux-nvdimm@lists.01.org>,
        <mchehab@kernel.org>, <me@tobin.cc>, <stfrench@microsoft.com>,
        <vishal.l.verma@intel.com>, Roman Bolshakov <r.bolshakov@yadro.com>
Subject: Re: [Ksummit-discuss] [PATCH v2 0/3] Maintainer Entry Profiles
Date:   Wed, 29 Apr 2020 16:55:27 +0300
Message-ID: <20200429135524.52802-1-r.bolshakov@yadro.com>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <yq1tv9fdfar.fsf@oracle.com>
References: <yq1tv9fdfar.fsf@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.17.204.212]
X-ClientProxiedBy: T-EXCH-01.corp.yadro.com (172.17.10.101) To
 T-EXCH-02.corp.yadro.com (172.17.10.102)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/11/19 5:40 PM, Martin K. Petersen wrote:
> After the Plumbers session last year I wrote this for SCSI based on a
> prior version by Christoph. It's gone a bit stale but I'll update it to
> match your template.
> 

Hi Martin,

The Maintainer profile is very helpful. Are you planning to send another
version and address Bart's comments?

Thanks,
Roman
