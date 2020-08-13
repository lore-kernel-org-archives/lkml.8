Return-Path: <SRS0=dFdc=BX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79654C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Aug 2020 13:03:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 482AE207DA
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Aug 2020 13:03:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597323789;
	bh=39+BFIgNuT6QhOffnjePjX9xFrI4Rlttm49wqJrWtTM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ucSfQSGpf7MqqVOEnYQYv7geEKT4H3S+YllaxEtIlYWDNIWtQe64keRIyInasMl5j
	 oM2nsm07FeVFd5MJDoa9J/kxEh7PEtfz7MYE21Z3mJ+YKBW10yhhXDCTYlzZHHGym6
	 UBOw6qJoVjEka1dOcFUlPTf2M9JpQjBLE3K6PZLg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726632AbgHMNDG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Aug 2020 09:03:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:56868 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726053AbgHMNDE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Aug 2020 09:03:04 -0400
Received: from quaco.ghostprotocols.net (177.207.136.251.dynamic.adsl.gvt.net.br [177.207.136.251])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D7CF92078D;
        Thu, 13 Aug 2020 13:03:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597323784;
        bh=39+BFIgNuT6QhOffnjePjX9xFrI4Rlttm49wqJrWtTM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=M8L5VGmKtrzpkoF/nuCrSOGLd3HZdZbKPM4FrSokHUBj0ILQqmGA1zmMbDokxLCqW
         esHAhHBhP+68iKWp6W3R1ADGMAft1fDklrlJvx7KEP3pIen+FWW3sV/RXQV7RP4Toj
         Y6dtMB8xkFtXqh60jZ8vCApEtKBt8KA586moVz1Q=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id B52644097F; Thu, 13 Aug 2020 10:03:01 -0300 (-03)
Date:   Thu, 13 Aug 2020 10:03:01 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Srikar Dronamraju <srikar@linux.vnet.ibm.com>
Cc:     Alexander Gordeev <agordeev@linux.ibm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Satheesh Rajendran <sathnaga@linux.vnet.ibm.com>,
        "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
        Balamuruhan S <bala24@linux.vnet.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>
Subject: Re: [PATCH v3 1/2] perf bench numa: fix cpumask memory leak in
 node_has_cpus()
Message-ID: <20200813130301.GP13995@kernel.org>
References: <cover.1597004831.git.agordeev@linux.ibm.com>
 <a002ebf17a3970e5d2dc7b9869dc180e68b88db4.1597004831.git.agordeev@linux.ibm.com>
 <CAM9d7cjLA29eOm6UU5FVE-Zeg7wm4bJaSdwMOH=ghDn=hfBo=A@mail.gmail.com>
 <20200813113041.GA1685@oc3871087118.ibm.com>
 <20200813120649.GA21578@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200813120649.GA21578@linux.vnet.ibm.com>
X-Url:  http://acmel.wordpress.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, Aug 13, 2020 at 05:36:49PM +0530, Srikar Dronamraju escreveu:
> Looks good to me.
> 
> Reviewed-by: Srikar Dronamraju <srikar@linux.vnet.ibm.com>

Thanks, applied.

- Arnaldo
