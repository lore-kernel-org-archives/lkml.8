Return-Path: <SRS0=Fjb+=5D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D367C10DCE
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 19:13:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E550320768
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 19:13:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=me.com header.i=@me.com header.b="AnPqBJmG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726975AbgCRTNv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Mar 2020 15:13:51 -0400
Received: from mr85p00im-hyfv06021301.me.com ([17.58.23.188]:36227 "EHLO
        mr85p00im-hyfv06021301.me.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726619AbgCRTNv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Mar 2020 15:13:51 -0400
X-Greylist: delayed 365 seconds by postgrey-1.27 at vger.kernel.org; Wed, 18 Mar 2020 15:13:51 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=me.com; s=1a1hai;
        t=1584558466; bh=W59Q3IPZStTRzJwL89Y5ugagdGKYOmdfb4lMadn5858=;
        h=Date:From:To:Subject:Message-ID:Content-Type;
        b=AnPqBJmG/gxtXlxn6ikbZ2lUFHd4lUdRyszLf66hRwppzIMevNhJu34ZqVHam1Q70
         jSEzKskcyyzibosxKvojqCElJ41tkusxHzPodSkoHZh19opy4AwNWgyU52KVSIfhHg
         h3GMVOneegyr9/HDJg5Q1mHiz9f5PMJ4t7O/8ljXavAUhhJ4sbs97ltPpTp9zdmS0O
         AXm+0NNIeDeK5HiAipwPbDPXbv9+IlOx+xXp25qwXjwm5zFBC2cF3D9H01L3RyZDXa
         j1L5DWZ5NJxyeQf4j/A5JzjeAYwxf+HnKzcVhQpGCX5/mcREK6eVSgmujAm4rCMUGa
         sRhpJVn0oVs2Q==
Received: from shwetrath.localdomain (unknown [66.199.8.131])
        by mr85p00im-hyfv06021301.me.com (Postfix) with ESMTPSA id 6847B403FB;
        Wed, 18 Mar 2020 19:07:45 +0000 (UTC)
Date:   Wed, 18 Mar 2020 15:07:43 -0400
From:   Vijay Thakkar <vijaythakkar@me.com>
To:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Kim Phillips <kim.phillips@amd.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Martin =?utf-8?B?TGnFoWth?= <mliska@suse.cz>,
        Jon Grimm <jon.grimm@amd.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v5 2/3] perf vendor events amd: add Zen2 events
Message-ID: <20200318190743.GA307603@shwetrath.localdomain>
References: <20200316225238.150154-1-vijaythakkar@me.com>
 <20200316225238.150154-3-vijaythakkar@me.com>
 <20200318142057.GD11531@kernel.org>
 <20200318152112.GA231037@shwetrath.localdomain>
 <20200318155245.GJ11531@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200318155245.GJ11531@kernel.org>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2020-03-18_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015 mlxscore=0
 mlxlogscore=890 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1908290000 definitions=main-2003180086
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Okay, should be updated now in the v6 series. Sorry for the last minute
change, and thanks for your patience.

-Vijay
