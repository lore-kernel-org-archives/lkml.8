Return-Path: <SRS0=29cB=4T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA883C3F2D7
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 21:11:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A06E02465E
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 21:11:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CcDtWLVm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726942AbgCBVLq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Mar 2020 16:11:46 -0500
Received: from mail-yw1-f66.google.com ([209.85.161.66]:46300 "EHLO
        mail-yw1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725781AbgCBVLq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Mar 2020 16:11:46 -0500
Received: by mail-yw1-f66.google.com with SMTP id y62so1193118ywd.13;
        Mon, 02 Mar 2020 13:11:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=pbl+fvhSHUwhsBl54qCM/DzyY9Ab6JRPXj8p7PWdhrQ=;
        b=CcDtWLVmd0DjhyHlXW/P2CvchNu8pFKL4EwiUnuwD0qUJtSVPNkKNExX4dy3GrfwZK
         HaytUVLalKyYoQUhwQFEXwGgLaGhQ5ojFhJ7C1Ei5XjyDydYu4MJvaoWcS5ind2+NXjX
         pQR1faum7vKXg6BnOphFYv4kUChx2U5VBP5LHrciK1CWmJ1zTq/h1AKTiEKOkfaZaxPQ
         GUa2jujePiypTGCiFQSRb9/np52Az14IXUd/vrrBKlhqNDq6m0b4fYdvfGPxgU8Za3rs
         YokmSUw3ToPS8n7seZQ5luqBmu9E1wGs92j6NoNkJUmOg/bRiCLsw8jo/WUF44hlFuxs
         dFiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=pbl+fvhSHUwhsBl54qCM/DzyY9Ab6JRPXj8p7PWdhrQ=;
        b=pKVJpILpHdScjbrMALDQFBa589MZYx15rfXcv82E3ZXb3wY9kHLKUXl1eXWk5Xe2As
         LAb0TLQRJunBvdeH5Xq9+anNE8r+gAUKXtmbWyZAnjaEdYhxkrXF8E6kzpGtK5vtfAsP
         AnTzIiIDXyEXEavNa8bqlIAsgHtlSqFykWvoxyz9M0lh/lQyrtBbRJCEHL1aeR6WgoOy
         LOG97roi81eDxEn5YEyP8eGaBQXqXYLFgE8QvIMah4A4hgouOm40ge65v2/+/1ktbS4z
         jLLiXGAJDP/SY3z+CGGoJn5yMwWvP+Ge6t7LW+mSwi2t8o9KCFjlR1QZ+NrKO70A5ydL
         O/4A==
X-Gm-Message-State: ANhLgQ0ELw2W55DfSqKh2pdRjU6NlC9kmGZw5em8haAupmqUhnbxXFN1
        BhCf29aCYcg2LtJ+GQKuviw=
X-Google-Smtp-Source: ADFU+vtc9tyo5rdEwqJNXOKVjwGb88UxGdKTkHseZV3wINnlUeIzfgB+7XpLkTjCZsn8jMSsWkpLqg==
X-Received: by 2002:a25:ab65:: with SMTP id u92mr969999ybi.193.1583183504875;
        Mon, 02 Mar 2020 13:11:44 -0800 (PST)
Received: from [192.168.1.46] (c-73-88-245-53.hsd1.tn.comcast.net. [73.88.245.53])
        by smtp.gmail.com with ESMTPSA id u4sm8397568ywu.26.2020.03.02.13.11.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 02 Mar 2020 13:11:44 -0800 (PST)
Subject: Re: [PATCH v2 07/12] docs: dt: convert of_unittest.txt to ReST
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org
References: <cover.1583135507.git.mchehab+huawei@kernel.org>
 <09f0a0877184ecdff1df1f6f6d38c164c6bdd8f6.1583135507.git.mchehab+huawei@kernel.org>
From:   Frank Rowand <frowand.list@gmail.com>
Message-ID: <13c4a1d3-9d12-9085-8e05-218a7ab511c1@gmail.com>
Date:   Mon, 2 Mar 2020 15:11:42 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <09f0a0877184ecdff1df1f6f6d38c164c6bdd8f6.1583135507.git.mchehab+huawei@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/2/20 1:59 AM, Mauro Carvalho Chehab wrote:
> - Add a SPDX header;
> - Adjust document and section titles;
> - Adjust numerated list markups;
> - Some whitespace fixes and new line breaks;
> - Mark literal blocks as such;
> - Add it to devicetree/index.rst.
> 
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> ---
>  Documentation/devicetree/index.rst            |   1 +
>  .../{of_unittest.txt => of_unittest.rst}      | 186 +++++++++---------
>  2 files changed, 98 insertions(+), 89 deletions(-)
>  rename Documentation/devicetree/{of_unittest.txt => of_unittest.rst} (54%)
> 
> diff --git a/Documentation/devicetree/index.rst b/Documentation/devicetree/index.rst
> index 308cac9d7021..ca83258fbba5 100644
> --- a/Documentation/devicetree/index.rst
> +++ b/Documentation/devicetree/index.rst
> @@ -12,3 +12,4 @@ Open Firmware and Device Tree
>     booting-without-of
>     changesets
>     dynamic-resolution-notes
> +   of_unittest
> diff --git a/Documentation/devicetree/of_unittest.txt b/Documentation/devicetree/of_unittest.rst
> similarity index 54%
> rename from Documentation/devicetree/of_unittest.txt
> rename to Documentation/devicetree/of_unittest.rst
> index 9fdd2de9b770..dea05214f3ad 100644
> --- a/Documentation/devicetree/of_unittest.txt
> +++ b/Documentation/devicetree/of_unittest.rst
> @@ -1,9 +1,13 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +==================================
>  Open Firmware Device Tree Unittest
> -----------------------------------
> +==================================
>  
>  Author: Gaurav Minocha <gaurav.minocha.os@gmail.com>
>  
>  1. Introduction
> +===============
>  
>  This document explains how the test data required for executing OF unittest
>  is attached to the live tree dynamically, independent of the machine's
> @@ -11,8 +15,8 @@ architecture.
>  
>  It is recommended to read the following documents before moving ahead.
>  
> -[1] Documentation/devicetree/usage-model.rst
> -[2] http://www.devicetree.org/Device_Tree_Usage
> +(1) Documentation/devicetree/usage-model.rst
> +(2) http://www.devicetree.org/Device_Tree_Usage

You caught this in 03/13.  The file has moved to:

   https://elinux.org/Device_Tree_Usage

-Frank


>  
>  OF Selftest has been designed to test the interface (include/linux/of.h)
>  provided to device driver developers to fetch the device information..etc.
> @@ -21,79 +25,82 @@ most of the device drivers in various use cases.
>  
>  
>  2. Test-data
> +============
>  
>  The Device Tree Source file (drivers/of/unittest-data/testcases.dts) contains
>  the test data required for executing the unit tests automated in
>  drivers/of/unittest.c. Currently, following Device Tree Source Include files
> -(.dtsi) are included in testcases.dts:
> +(.dtsi) are included in testcases.dts::
>  
> -drivers/of/unittest-data/tests-interrupts.dtsi
> -drivers/of/unittest-data/tests-platform.dtsi
> -drivers/of/unittest-data/tests-phandle.dtsi
> -drivers/of/unittest-data/tests-match.dtsi
> +    drivers/of/unittest-data/tests-interrupts.dtsi
> +    drivers/of/unittest-data/tests-platform.dtsi
> +    drivers/of/unittest-data/tests-phandle.dtsi
> +    drivers/of/unittest-data/tests-match.dtsi
>  
> -When the kernel is build with OF_SELFTEST enabled, then the following make rule
> +When the kernel is build with OF_SELFTEST enabled, then the following make
> +rule::
>  
> -$(obj)/%.dtb: $(src)/%.dts FORCE
> -	$(call if_changed_dep, dtc)
> +    $(obj)/%.dtb: $(src)/%.dts FORCE
> +	    $(call if_changed_dep, dtc)
>  
>  is used to compile the DT source file (testcases.dts) into a binary blob
>  (testcases.dtb), also referred as flattened DT.
>  
>  After that, using the following rule the binary blob above is wrapped as an
> -assembly file (testcases.dtb.S).
> +assembly file (testcases.dtb.S)::
>  
> -$(obj)/%.dtb.S: $(obj)/%.dtb
> -	$(call cmd, dt_S_dtb)
> +    $(obj)/%.dtb.S: $(obj)/%.dtb
> +	    $(call cmd, dt_S_dtb)
>  
>  The assembly file is compiled into an object file (testcases.dtb.o), and is
>  linked into the kernel image.
>  
>  
>  2.1. Adding the test data
> +-------------------------
>  
>  Un-flattened device tree structure:
>  
>  Un-flattened device tree consists of connected device_node(s) in form of a tree
> -structure described below.
> +structure described below::
>  
> -// following struct members are used to construct the tree
> -struct device_node {
> -    ...
> -    struct  device_node *parent;
> -    struct  device_node *child;
> -    struct  device_node *sibling;
> -    ...
> - };
> +    // following struct members are used to construct the tree
> +    struct device_node {
> +	...
> +	struct  device_node *parent;
> +	struct  device_node *child;
> +	struct  device_node *sibling;
> +	...
> +    };
>  
>  Figure 1, describes a generic structure of machine's un-flattened device tree
>  considering only child and sibling pointers. There exists another pointer,
> -*parent, that is used to traverse the tree in the reverse direction. So, at
> +``*parent``, that is used to traverse the tree in the reverse direction. So, at
>  a particular level the child node and all the sibling nodes will have a parent
>  pointer pointing to a common node (e.g. child1, sibling2, sibling3, sibling4's
> -parent points to root node)
> +parent points to root node)::
>  
> -root ('/')
> -   |
> -child1 -> sibling2 -> sibling3 -> sibling4 -> null
> -   |         |           |           |
> -   |         |           |          null
> -   |         |           |
> -   |         |        child31 -> sibling32 -> null
> -   |         |           |          |
> -   |         |          null       null
> -   |         |
> -   |      child21 -> sibling22 -> sibling23 -> null
> -   |         |          |            |
> -   |        null       null         null
> -   |
> -child11 -> sibling12 -> sibling13 -> sibling14 -> null
> -   |           |           |            |
> -   |           |           |           null
> -   |           |           |
> -  null        null       child131 -> null
> -                           |
> -                          null
> +    root ('/')
> +    |
> +    child1 -> sibling2 -> sibling3 -> sibling4 -> null
> +    |         |           |           |
> +    |         |           |          null
> +    |         |           |
> +    |         |        child31 -> sibling32 -> null
> +    |         |           |          |
> +    |         |          null       null
> +    |         |
> +    |      child21 -> sibling22 -> sibling23 -> null
> +    |         |          |            |
> +    |        null       null         null
> +    |
> +    child11 -> sibling12 -> sibling13 -> sibling14 -> null
> +    |           |           |            |
> +    |           |           |           null
> +    |           |           |
> +    null        null       child131 -> null
> +			    |
> +			    null
>  
>  Figure 1: Generic structure of un-flattened device tree
>  
> @@ -101,10 +108,10 @@ Figure 1: Generic structure of un-flattened device tree
>  Before executing OF unittest, it is required to attach the test data to
>  machine's device tree (if present). So, when selftest_data_add() is called,
>  at first it reads the flattened device tree data linked into the kernel image
> -via the following kernel symbols:
> +via the following kernel symbols::
>  
> -__dtb_testcases_begin - address marking the start of test data blob
> -__dtb_testcases_end   - address marking the end of test data blob
> +    __dtb_testcases_begin - address marking the start of test data blob
> +    __dtb_testcases_end   - address marking the end of test data blob
>  
>  Secondly, it calls of_fdt_unflatten_tree() to unflatten the flattened
>  blob. And finally, if the machine's device tree (i.e live tree) is present,
> @@ -113,15 +120,15 @@ attaches itself as a live device tree.
>  
>  attach_node_and_children() uses of_attach_node() to attach the nodes into the
>  live tree as explained below. To explain the same, the test data tree described
> - in Figure 2 is attached to the live tree described in Figure 1.
> +in Figure 2 is attached to the live tree described in Figure 1::
>  
> -root ('/')
> -    |
> - testcase-data
> -    |
> - test-child0 -> test-sibling1 -> test-sibling2 -> test-sibling3 -> null
> -    |               |                |                |
> - test-child01      null             null             null
> +    root ('/')
> +	|
> +    testcase-data
> +	|
> +    test-child0 -> test-sibling1 -> test-sibling2 -> test-sibling3 -> null
> +	|               |                |                |
> +    test-child01      null             null             null
>  
>  
>  Figure 2: Example test data tree to be attached to live tree.
> @@ -134,39 +141,39 @@ In the function of_attach_node(), the new node is attached as the child of the
>  given parent in live tree. But, if parent already has a child then the new node
>  replaces the current child and turns it into its sibling. So, when the testcase
>  data node is attached to the live tree above (Figure 1), the final structure is
> - as shown in Figure 3.
> +as shown in Figure 3::
>  
> -root ('/')
> -   |
> -testcase-data -> child1 -> sibling2 -> sibling3 -> sibling4 -> null
> -   |               |          |           |           |
> - (...)             |          |           |          null
> -                   |          |         child31 -> sibling32 -> null
> -                   |          |           |           |
> -                   |          |          null        null
> -                   |          |
> -                   |        child21 -> sibling22 -> sibling23 -> null
> -                   |          |           |            |
> -                   |         null        null         null
> -                   |
> -                child11 -> sibling12 -> sibling13 -> sibling14 -> null
> -                   |          |            |            |
> -                  null       null          |           null
> -                                           |
> -                                        child131 -> null
> -                                           |
> -                                          null
> ------------------------------------------------------------------------
> +    root ('/')
> +    |
> +    testcase-data -> child1 -> sibling2 -> sibling3 -> sibling4 -> null
> +    |               |          |           |           |
> +    (...)             |          |           |          null
> +		    |          |         child31 -> sibling32 -> null
> +		    |          |           |           |
> +		    |          |          null        null
> +		    |          |
> +		    |        child21 -> sibling22 -> sibling23 -> null
> +		    |          |           |            |
> +		    |         null        null         null
> +		    |
> +		    child11 -> sibling12 -> sibling13 -> sibling14 -> null
> +		    |          |            |            |
> +		    null       null          |           null
> +					    |
> +					    child131 -> null
> +					    |
> +					    null
> +    -----------------------------------------------------------------------
>  
> -root ('/')
> -   |
> -testcase-data -> child1 -> sibling2 -> sibling3 -> sibling4 -> null
> -   |               |          |           |           |
> -   |             (...)      (...)       (...)        null
> -   |
> -test-sibling3 -> test-sibling2 -> test-sibling1 -> test-child0 -> null
> -   |                |                   |                |
> -  null             null                null         test-child01
> +    root ('/')
> +    |
> +    testcase-data -> child1 -> sibling2 -> sibling3 -> sibling4 -> null
> +    |               |          |           |           |
> +    |             (...)      (...)       (...)        null
> +    |
> +    test-sibling3 -> test-sibling2 -> test-sibling1 -> test-child0 -> null
> +    |                |                   |                |
> +    null             null                null         test-child01
>  
>  
>  Figure 3: Live device tree structure after attaching the testcase-data.
> @@ -176,7 +183,7 @@ Astute readers would have noticed that test-child0 node becomes the last
>  sibling compared to the earlier structure (Figure 2). After attaching first
>  test-child0 the test-sibling1 is attached that pushes the child node
>  (i.e. test-child0) to become a sibling and makes itself a child node,
> - as mentioned above.
> +as mentioned above.
>  
>  If a duplicate node is found (i.e. if a node with same full_name property is
>  already present in the live tree), then the node isn't attached rather its
> @@ -185,6 +192,7 @@ update_node_properties().
>  
>  
>  2.2. Removing the test data
> +---------------------------
>  
>  Once the test case execution is complete, selftest_data_remove is called in
>  order to remove the device nodes attached initially (first the leaf nodes are
> 

