Return-Path: <SRS0=ABJN=6Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1161DC38A2A
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 00:56:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E6A3F24954
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 00:56:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729459AbgEKA4Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 May 2020 20:56:25 -0400
Received: from mga05.intel.com ([192.55.52.43]:1592 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729302AbgEKA4Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 May 2020 20:56:24 -0400
IronPort-SDR: 7LE367MqfeTm+caxdGA9YEyEcoE2hYt0G1ThVtAIRKAZ22GYsroJcgt/odGkM9MId8znyBk4HY
 TMwVMhj2AIXA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2020 17:56:24 -0700
IronPort-SDR: p9cG2sLzEnGofGBrJBozvTdYgWEAdpRBOaLISQutzOhWg+nqHMAznzgjluOzE0KtYSRJMgJ/Lc
 L0wPiuvMAcWQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,377,1583222400"; 
   d="scan'208";a="261589737"
Received: from tassilo.jf.intel.com (HELO tassilo.localdomain) ([10.7.201.21])
  by orsmga003.jf.intel.com with ESMTP; 10 May 2020 17:56:24 -0700
Received: by tassilo.localdomain (Postfix, from userid 1000)
        id 12662301C52; Sun, 10 May 2020 17:56:24 -0700 (PDT)
Date:   Sun, 10 May 2020 17:56:24 -0700
From:   Andi Kleen <ak@linux.intel.com>
To:     Joakim Zhang <qiangqing.zhang@nxp.com>
Cc:     kajoljain <kjain@linux.ibm.com>,
        "acme@kernel.org" <acme@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
        Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>,
        Kan Liang <kan.liang@linux.intel.com>,
        Madhavan Srinivasan <maddy@linux.vnet.ibm.com>,
        Anju T Sudhakar <anju@linux.vnet.ibm.com>,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>, yao.jin@intel.com
Subject: Re: [RFC] Issue in final aggregate value, in case of multiple events
 present in metric expression
Message-ID: <20200511005624.GL3538@tassilo.jf.intel.com>
References: <20200212054102.9259-1-kjain@linux.ibm.com>
 <DB7PR04MB46186AB5557F4D04FD5C4FEAE6160@DB7PR04MB4618.eurprd04.prod.outlook.com>
 <be86ba99-ab5a-c845-46b6-8081edee00ca@linux.ibm.com>
 <DB7PR04MB461807389FDF9629ACA04533E6130@DB7PR04MB4618.eurprd04.prod.outlook.com>
 <cb9b353b-c18a-0064-eb72-a6c91d5fdec9@linux.ibm.com>
 <DB7PR04MB4618D0696D39AC5D44FF5A51E6F50@DB7PR04MB4618.eurprd04.prod.outlook.com>
 <6f98d281-f3de-b547-70d4-8fc95515b12f@linux.ibm.com>
 <DB8PR04MB6795DE74059AD3CA8DA7BB5CE6A30@DB8PR04MB6795.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DB8PR04MB6795DE74059AD3CA8DA7BB5CE6A30@DB8PR04MB6795.eurprd04.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 09, 2020 at 05:52:53AM +0000, Joakim Zhang wrote:
> 
> Hi Arnaldo,
> 
> Kajol reflects this issue for almost two months, got no feedbacks, do you have any comments? That could be appreciated if you can look into it. Thanks a lot!

Jin Yao did a lot of fixes to metrics recently. Does it still happen with
the latest tip tree?

-Andi
