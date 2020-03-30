Return-Path: <SRS0=Mt+e=5P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0CD4C43331
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 07:44:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 985EE20733
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 07:44:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585554273;
	bh=+A3gTkI/ug5ftQTazxn0GQRu8am1syO1/fPzFWLAqzo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=aIe+PT9su7Sc8uAsPnU2iY29UjmOTIclhpPsA9MN81HRhjbk0EtLuE5/LxyCfpfZL
	 ewTUdUPW/IEJ9Iy9NuKE3OG2VPo96MShlbh6HVxJTDQ3RDg38UFkZnjtpwUi6sevS6
	 w0GrVDEPiawHkbO3Hfz0iZ5JIPS//c6pOesYiCnY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729559AbgC3Hoc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Mar 2020 03:44:32 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:40909 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728766AbgC3Hob (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Mar 2020 03:44:31 -0400
Received: by mail-wm1-f68.google.com with SMTP id a81so20714147wmf.5;
        Mon, 30 Mar 2020 00:44:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=+lQxT4rOXYS7igvmWe+aSLt8H9b/hooDSaFj9dpIoBo=;
        b=sXB3Axt3bNhLZM4yzWIsP8VuxlH6kiWXUpjSZd93e6MR4/ML7UYW7UltVKYUH0rV93
         Ev80J0qi5a9JpLUExrvqq0XFdw3GwLqk2T+quHuw55eio69i1xnbNpyF2bThds3+jNEb
         V2U+nBHDuWacYhv5s88y8Ozcy49+oJ7w1Eky0yRA4GPdb/64PCT1D4oqPAic/4FD5e9G
         WH1DzkV82oO+RLuzoLZIbfBIklx657PvJGkhEotRL1TIezZHCCTTUV3E+VmysclcefZk
         2iSbjt27A+/KsuAr6ebt0YeZVI66NiG4cyoPNofKmHpQigs5gU9y/9eJoQiOwC7dVsh1
         FhDA==
X-Gm-Message-State: ANhLgQ2Ct3curkqzdWT/eevI4jDwwpVc1+sK4Schy/AqqRtb7EWn4Ke+
        J3/9SwzFGjBAZRXMM7dorDQ=
X-Google-Smtp-Source: ADFU+vv5zPfvR6n12LY62/oTKOim3ahnJoTy88I5ftZ61ckUgrrKlF39ljyabbjxRYuNzhw3oecv9w==
X-Received: by 2002:a7b:cc06:: with SMTP id f6mr11831239wmh.65.1585554268222;
        Mon, 30 Mar 2020 00:44:28 -0700 (PDT)
Received: from localhost (ip-37-188-180-223.eurotel.cz. [37.188.180.223])
        by smtp.gmail.com with ESMTPSA id p16sm20037964wmi.40.2020.03.30.00.44.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Mar 2020 00:44:27 -0700 (PDT)
Date:   Mon, 30 Mar 2020 09:44:26 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Baoquan He <bhe@redhat.com>
Cc:     Hoan Tran <Hoan@os.amperecomputing.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Oscar Salvador <osalvador@suse.de>,
        Pavel Tatashin <pavel.tatashin@microsoft.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Alexander Duyck <alexander.h.duyck@linux.intel.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "David S. Miller" <davem@davemloft.net>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        "open list:MEMORY MANAGEMENT" <linux-mm@kvack.org>,
        linux-arm-kernel@lists.infradead.org, linux-s390@vger.kernel.org,
        sparclinux@vger.kernel.org, x86@kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        lho@amperecomputing.com, mmorana@amperecomputing.com
Subject: Re: [PATCH v3 0/5] mm: Enable CONFIG_NODES_SPAN_OTHER_NODES by
 default for NUMA
Message-ID: <20200330074426.GB14243@dhcp22.suse.cz>
References: <1585420282-25630-1-git-send-email-Hoan@os.amperecomputing.com>
 <20200329001924.GS3039@MiWiFi-R3L-srv>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200329001924.GS3039@MiWiFi-R3L-srv>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun 29-03-20 08:19:24, Baoquan He wrote:
> On 03/28/20 at 11:31am, Hoan Tran wrote:
> > In NUMA layout which nodes have memory ranges that span across other nodes,
> > the mm driver can detect the memory node id incorrectly.
> > 
> > For example, with layout below
> > Node 0 address: 0000 xxxx 0000 xxxx
> > Node 1 address: xxxx 1111 xxxx 1111
> 
> Sorry, I read this example several times, but still don't get what it
> means. Can it be given with real hex number address as an exmaple? I
> mean just using the memory layout you have seen from some systems. The
> change looks interesting though.

Does this make it more clear?
           physical address range and its node associaion
         [0 0 0 0 1 1 1 1 0 0 0 0 1 1 1 1 0 0 0 0 1 1 1 1]
-- 
Michal Hocko
SUSE Labs
