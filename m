Return-Path: <SRS0=EowN=3M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D2FEC2D0DB
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jan 2020 18:05:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2358420718
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jan 2020 18:05:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="t1FZb1fR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729359AbgAWSFF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jan 2020 13:05:05 -0500
Received: from mail-vs1-f74.google.com ([209.85.217.74]:43706 "EHLO
        mail-vs1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729345AbgAWSFE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jan 2020 13:05:04 -0500
Received: by mail-vs1-f74.google.com with SMTP id j8so466077vsm.10
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jan 2020 10:05:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=IgY/A9lI8I0CLEHHbAfWjUttLZ/uMo5ZHLdhVrD7cM0=;
        b=t1FZb1fRlGn6sS3KiIywlF3SWXZSC72vi3l8yghm1rqJkGVi2ppxi2bhsdIjvKvpRo
         mtWcSzCLmK9615UMLkHpgpsmNt5T84sa65TDnvwPSa9ngmlIgsKEROMy5IpuHkvfb8N7
         bCjmso/kge2qOgVpMLvorx9kPfR6WTEwTFQ8ai/lbr8rUqpqvjYUnTSXQVQ71Drj5GJK
         RECoQDzgsJUdJwfKMT9nw/Gcan8lFs4CF7xzacTYrzpmO7QXUtJ0wOvCMIvFcmKTG6ds
         S0JhBqH4xNZ9AdbRXFzXIauav8aPfCE3jZORlJTJUBw0/YItGp4DWvk1Kp8cXJfqmuFI
         13ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=IgY/A9lI8I0CLEHHbAfWjUttLZ/uMo5ZHLdhVrD7cM0=;
        b=R6DoAdmqz3Elfp0rKfYMHoSGUd6hA3j6nofREzl1OCI9VRzt0d7OQHepfvuS9g6IDr
         1QDs25o3AR8nuEe8XxQJg8zOPifm6ZH7VnBQrNYpud5ZGF4JNOnxvVSs74jjPhYJB9d1
         5zE9tTdZZ/tAF/C7JWVFTfDeFSEtEPBhUKJtV/FicJUyHOM3t669dWXTtvAt9O50Mxcb
         XGjPbQIEZtMYGROzXqrrCvB4n4gND0QPffcBZVWTmO+R1vYmLvToo7Ucs24g1JFF4SnY
         VzzdaczeTlK5JcMnYoq3qmU03OBKfaUrs2lFa7ECrg2t/dDf7gpWO4yNEUNr1nuwfeip
         W35A==
X-Gm-Message-State: APjAAAVkinz+gaB+iNPrgMCZ/Ok1OO683Iw46H1xNHkwpf190sjJ/+5F
        H4pPWfO8X/lDxW0mAWYbWPMrpsUVb0LlyExEjgn2pMCssL3v6KEIS0Dv4C8hcRmjrVDzZtphmg0
        VJd/JS963okWq/icgwLegPI/+5XdIkFw6EI1n1QEzIBn3Dd3hO5+hfSWA/euzegkPLLWo5to4
X-Google-Smtp-Source: APXvYqxXhcIT67XYPNyAtt7N43so6bSsWc4OopxKKv8aAXTznOXWZ7A8M1Li4/dumBajBFClbx8iUmgtV+QX
X-Received: by 2002:a67:e44b:: with SMTP id n11mr7496089vsm.115.1579802702764;
 Thu, 23 Jan 2020 10:05:02 -0800 (PST)
Date:   Thu, 23 Jan 2020 10:04:36 -0800
In-Reply-To: <20200123180436.99487-1-bgardon@google.com>
Message-Id: <20200123180436.99487-11-bgardon@google.com>
Mime-Version: 1.0
References: <20200123180436.99487-1-bgardon@google.com>
X-Mailer: git-send-email 2.25.0.341.g760bfbb309-goog
Subject: [PATCH v4 10/10] KVM: selftests: Move memslot 0 above KVM internal memslots
From:   Ben Gardon <bgardon@google.com>
To:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Cannon Matthews <cannonmatthews@google.com>,
        Peter Xu <peterx@redhat.com>,
        Andrew Jones <drjones@redhat.com>,
        Peter Shier <pshier@google.com>,
        Oliver Upton <oupton@google.com>,
        Ben Gardon <bgardon@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

KVM creates internal memslots between 3 and 4 GiB paddrs on the first
vCPU creation. If memslot 0 is large enough it collides with these
memslots an causes vCPU creation to fail. Instead of creating memslot 0
at paddr 0, start it 4G into the guest physical address space.

Signed-off-by: Ben Gardon <bgardon@google.com>
---
 tools/testing/selftests/kvm/lib/kvm_util.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/kvm/lib/kvm_util.c b/tools/testing/selftests/kvm/lib/kvm_util.c
index 5b971c04f1643..427c88d32e988 100644
--- a/tools/testing/selftests/kvm/lib/kvm_util.c
+++ b/tools/testing/selftests/kvm/lib/kvm_util.c
@@ -130,9 +130,11 @@ _Static_assert(sizeof(vm_guest_mode_string)/sizeof(char *) == NUM_VM_MODES,
  *
  * Creates a VM with the mode specified by mode (e.g. VM_MODE_P52V48_4K).
  * When phy_pages is non-zero, a memory region of phy_pages physical pages
- * is created and mapped starting at guest physical address 0.  The file
- * descriptor to control the created VM is created with the permissions
- * given by perm (e.g. O_RDWR).
+ * is created, starting at 4G into the guest physical address space to avoid
+ * KVM internal memslots which map the region between 3G and 4G. If tests need
+ * to use the physical region between 0 and 3G, they can allocate another
+ * memslot for that region. The file descriptor to control the created VM is
+ * created with the permissions given by perm (e.g. O_RDWR).
  */
 struct kvm_vm *_vm_create(enum vm_guest_mode mode, uint64_t phy_pages, int perm)
 {
@@ -231,7 +233,8 @@ struct kvm_vm *_vm_create(enum vm_guest_mode mode, uint64_t phy_pages, int perm)
 	vm->vpages_mapped = sparsebit_alloc();
 	if (phy_pages != 0)
 		vm_userspace_mem_region_add(vm, VM_MEM_SRC_ANONYMOUS,
-					    0, 0, phy_pages, 0);
+					    KVM_INTERNAL_MEMSLOTS_END_PADDR,
+					    0, phy_pages, 0);
 
 	return vm;
 }
-- 
2.25.0.341.g760bfbb309-goog

